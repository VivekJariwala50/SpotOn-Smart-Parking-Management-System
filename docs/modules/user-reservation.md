# User Reservation Module (Driver Side) — Outline

## 1. Purpose
Enable a driver to:
- search for parking near a destination/time window
- view available spots and pricing
- reserve a spot for a specific period
- receive confirmation (reservation details + status)
- cancel a reservation (within policy)

## 2. Scope (MVP)
### In Scope
- Create reservation for an available spot and time window
- Validate availability + prevent double-booking
- Calculate price estimate (simple rules)
- Confirm reservation + return reservation ID
- View reservation details (by reservation ID or user)
- Cancel reservation (basic policy)

### Out of Scope (Later)
- Payments (handled in Payment module)
- Dynamic pricing optimization
- Waitlists, overbooking strategies
- QR entry/exit, ANPR, sensor integration
- Notifications (email/SMS/push)
- Loyalty, coupons, memberships

## 3. Actors & User Stories
### Actor: Driver (Authenticated)
- As a driver, I want to reserve a spot for a time window so that I can park without searching.
- As a driver, I want to see the total estimated cost before confirming a reservation.
- As a driver, I want to view my upcoming reservations so I can plan my trip.
- As a driver, I want to cancel a reservation within the allo
