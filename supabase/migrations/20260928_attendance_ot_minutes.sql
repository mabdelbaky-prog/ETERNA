-- Adds ot_minutes so OT can be stored directly (ZKTeco's own summary report
-- computes OT1/OT2/OT3 itself; there's no check-out time to derive it from).
-- Run this in the Supabase SQL editor after 20260927_attendance.sql.

alter table attendance_records
  add column if not exists ot_minutes numeric not null default 0;
