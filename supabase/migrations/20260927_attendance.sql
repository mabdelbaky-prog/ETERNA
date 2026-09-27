-- Attendance module: ZKTeco import, manual entry, self-reports.
-- Run this once in the Supabase SQL editor before using the Attendance tab.

create table if not exists attendance_records (
  id uuid primary key default gen_random_uuid(),
  employee_id uuid not null references employees(id) on delete cascade,
  date date not null,
  check_in time,
  check_out time,
  late_minutes numeric not null default 0,
  status text not null default 'present', -- present | absent | late | half_day
  source text not null default 'manual',  -- zkteco_import | manual | self_reported
  self_report_status text,                -- pending | approved | rejected (self_reported only)
  note text,
  created_by text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (employee_id, date)
);

create index if not exists attendance_records_date_idx on attendance_records(date);
create index if not exists attendance_records_employee_idx on attendance_records(employee_id);

-- Settings: shift_start ('09:00'), shift_end ('17:00'), grace_minutes ('15')
-- are read from the existing `settings` table (key/value) — no new columns needed there.
