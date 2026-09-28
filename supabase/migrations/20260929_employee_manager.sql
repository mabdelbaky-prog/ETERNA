-- Adds a simple one-level org chart: each employee can have a manager.
-- Run this in the Supabase SQL editor.

alter table employees
  add column if not exists manager_id uuid references employees(id) on delete set null;
