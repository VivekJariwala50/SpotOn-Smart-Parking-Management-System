-- One-time (idempotent) migration: pending approvals, promo_code, bulk group links,
-- and slot overlap rules that include PENDING_APPROVAL.
--
-- Run in Supabase: SQL Editor, as a role that can CREATE EXTENSION and ALTER TABLE
-- (often the "postgres" user / dashboard — not the anon pooler role the app may use).
--
-- After this, group and single-slot booking with status PENDING_APPROVAL will work.

CREATE EXTENSION IF NOT EXISTS btree_gist;

ALTER TABLE reservations
  ADD COLUMN IF NOT EXISTS promo_code VARCHAR(64);

ALTER TABLE reservations
  ADD COLUMN IF NOT EXISTS bulk_group_id UUID;

CREATE INDEX IF NOT EXISTS idx_reservations_bulk_group_id
  ON reservations (bulk_group_id)
  WHERE bulk_group_id IS NOT NULL;

-- Allow operator approval flow and related statuses
ALTER TABLE reservations DROP CONSTRAINT IF EXISTS reservations_status_check;
ALTER TABLE reservations
  ADD CONSTRAINT reservations_status_check
  CHECK (
    status = ANY (
      ARRAY[
        'CONFIRMED',
        'CANCELLED',
        'EXPIRED',
        'PENDING_APPROVAL',
        'REJECTED'
      ]::text[]
    )
  );

-- Single overlap rule: no overlapping active holds (confirmed or awaiting approval) per slot
ALTER TABLE reservations DROP CONSTRAINT IF EXISTS reservations_confirmed_no_overlap;
ALTER TABLE reservations DROP CONSTRAINT IF EXISTS reservations_no_overlap_confirmed;
ALTER TABLE reservations DROP CONSTRAINT IF EXISTS reservations_slot_booking_overlap;

ALTER TABLE reservations
  ADD CONSTRAINT reservations_slot_booking_overlap
  EXCLUDE USING gist (
    slot_id WITH =,
    tstzrange(start_time, end_time, '[)') WITH &&
  )
  WHERE (status IN ('CONFIRMED', 'PENDING_APPROVAL'));
