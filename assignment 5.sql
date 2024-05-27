create table empls (
    emp_id int primary key,
    name varchar(20),
    manager_id int null,
    foreign key (manager_id) references empls(emp_id)
);

insert into empls values
(1, 'rakhi', null),
(2, 'rithvik', 1),
(3, 'purandher', 2),
(4, 'vijay', 2),
(5, 'srinivas', 3),
(6, 'vipul', 5),
(7, 'praneeth', 4),
(8, 'pranav', 6);

select * from empls;

create procedure dbo.org_tree
@input_empid int
as
begin
    with org_tree as (
        select emp_id, name, manager_id, 1 as hierarchyLevel
        from empls
        where emp_id = @input_empid
        union all
        select e.emp_id, e.name, e.manager_id, ot.hierarchyLevel + 1
        from empls e
        inner join org_tree ot on e.manager_id = ot.emp_id
    )
    
    select ot.emp_id, ot.name, coalesce(e.name, 'ceo') as managerName, ot.hierarchyLevel
    from org_tree ot
    left join empls e on ot.manager_id = e.emp_id
    order by ot.hierarchyLevel desc;
end;
