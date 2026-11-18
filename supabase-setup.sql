-- FixTecno Sur: ejecutar una vez en el editor SQL del proyecto Supabase.
-- El identificador de usuario es el de la cuenta compartida de Supabase Auth.
create table if not exists public.fixtecno_presupuestos (
  id uuid primary key,
  owner_id uuid not null references auth.users(id),
  revision integer not null check (revision > 0),
  data jsonb not null,
  updated_at timestamptz not null default now()
);
create index if not exists fixtecno_presupuestos_owner on public.fixtecno_presupuestos(owner_id);
alter table public.fixtecno_presupuestos enable row level security;
revoke all on table public.fixtecno_presupuestos from anon;
revoke all on table public.fixtecno_presupuestos from authenticated;
grant select, insert, update on table public.fixtecno_presupuestos to authenticated;
drop policy if exists "fts_select_own" on public.fixtecno_presupuestos;
drop policy if exists "fts_insert_own" on public.fixtecno_presupuestos;
drop policy if exists "fts_update_own" on public.fixtecno_presupuestos;
create policy "fts_select_own" on public.fixtecno_presupuestos for select to authenticated using ((select auth.uid()) = owner_id);
create policy "fts_insert_own" on public.fixtecno_presupuestos for insert to authenticated with check ((select auth.uid()) = owner_id);
create policy "fts_update_own" on public.fixtecno_presupuestos for update to authenticated using ((select auth.uid()) = owner_id) with check ((select auth.uid()) = owner_id);
create or replace function public.fixtecno_set_updated_at() returns trigger language plpgsql set search_path = '' as $$
begin
  new.updated_at = now();
  return new;
end;
$$;
drop trigger if exists fixtecno_updated_at on public.fixtecno_presupuestos;
create trigger fixtecno_updated_at before update on public.fixtecno_presupuestos for each row execute function public.fixtecno_set_updated_at();
