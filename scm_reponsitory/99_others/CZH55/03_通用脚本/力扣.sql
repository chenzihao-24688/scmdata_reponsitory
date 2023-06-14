--1.组合两张表
select p.FirstName, p.LastName, a.City, a.State
  from Person p
  left join Address a
    on p.PersonId = a.PersonId
--2.第二高的薪水
select max(e.Salay)
  from Employee e
 where e.Salay < (select max(e1.Salay) from Employee e1)
--3.获取第n高的薪水
