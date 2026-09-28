-- Stores manager justifications uploaded back via the Exceptions report round-trip.
-- Run this in the Supabase SQL editor after the earlier attendance migrations.

alter table attendance_records
  add column if not exists justification text,
  add column if not exists manager_signature text;
