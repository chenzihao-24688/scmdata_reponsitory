--1.������ű�
select p.FirstName, p.LastName, a.City, a.State
  from Person p
  left join Address a
    on p.PersonId = a.PersonId
--2.�ڶ��ߵ�нˮ
select max(e.Salay)
  from Employee e
 where e.Salay < (select max(e1.Salay) from Employee e1)
--3.��ȡ��n�ߵ�нˮ
