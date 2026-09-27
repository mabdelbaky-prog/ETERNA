-- Void + re-run support for payroll_runs.
-- Run this once in the Supabase SQL editor (Project > SQL Editor) before using
-- the "Void" button in the History tab.

alter table payroll_runs
  add column if not exists voided_at timestamptz,
  add column if not exists void_reason text;

alter table payroll_lines
  add column if not exists loan_id uuid references loans(id);

create table if not exists leave_accrual_log (
  id uuid primary key default gen_random_uuid(),
  run_id uuid not null references payroll_runs(id) on delete cascade,
  employee_id uuid not null references employees(id) on delete cascade,
  accrued_delta numeric not null,
  created_at timestamptz not null default now()
);

create index if not exists leave_accrual_log_run_id_idx on leave_accrual_log(run_id);
