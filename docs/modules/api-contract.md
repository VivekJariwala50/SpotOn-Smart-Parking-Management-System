# Smart Parking System API Contract (MVP)

## Reservation APIs

### Create Reservation
POST /api/reservations

Request:
{
  "user_id": "string",
  "spot_id": "string",
  "start_time": "datetime",
  "end_time": "datetime"
}

Response:
{
  "reservation_id": "string",
  "status": "CONFIRMED",
  "price_estimate": "number"
}

---

### Get Reservation
GET /api/reservations/{reservation_id}

---

### Cancel Reservation
POST /api/reservations/{reservation_id}/cancel

---

## Parking Slot APIs

### List Available Slots
GET /api/slots?location=&start_time=&end_time=

---

### Create Parking Slot (Operator)
POST /api/slots

---

### Update Slot Availability
PATCH /api/slots/{spot_id}
