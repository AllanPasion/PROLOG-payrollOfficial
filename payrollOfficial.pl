:- dynamic employee/11.

menu :-
    nl,
    write('Payroll System'), nl,
    write('1. Add Employee'), nl,
    write('2. Edit Employee'), nl,
    write('3. Delete Employee'), nl,
    write('4. Compute Salary'), nl,
    write('5. View Employee'), nl,
    write('6. Save Records'), nl,
    write('7. Load Records'), nl,
    write('8. Exit'), nl,
    write('Enter choice: '), flush_output,
    read_line_to_string(user_input, ChoiceStr),
    atom_number(ChoiceStr, Choice),
    process_choice(Choice).

process_choice(1) :- write('Adding employee...'), nl, add_employee, nl, menu.
process_choice(2) :- write('Editing employee...'), nl, edit_employee, nl, menu.
process_choice(3) :- write('Deleting employee...'), nl, delete_employee, nl, menu.
process_choice(4) :- write('Computing salary...'), nl, compute_salary, nl, menu.
process_choice(5) :- write('Viewing employee...'), nl, display_employee, nl, menu.
process_choice(6) :- write('Saving records...'), nl, save_records, nl, menu.
process_choice(7) :- write('Loading records...'), nl, load_records, nl, menu.
process_choice(8) :- write('Exiting program...'), nl, halt.
process_choice(_) :- write('Invalid choice! Try again.'), nl, menu.

add_employee :-
    nl, write('Enter Employee ID: '), flush_output,
    read_line_to_string(user_input, EmpIDStr), atom_number(EmpIDStr, EmpID),
    write('Enter Name: '), flush_output,
    read_line_to_string(user_input, Name),
    write('Enter Date Hired (YYYY-MM-DD): '), flush_output,
    read_line_to_string(user_input, DateHired),
    write('Enter Department: '), flush_output,
    read_line_to_string(user_input, Dept),
    write('Enter Position: '), flush_output,
    read_line_to_string(user_input, Position),
    write('Enter Employment Status (probationary/permanent/contractual): '), flush_output,
    read_line_to_string(user_input, Status),
    write('Enter Rate per Hour: '), flush_output,
    read_line_to_string(user_input, RateStr), atom_number(RateStr, Rate),
    write('Enter Hours Worked: '), flush_output,
    read_line_to_string(user_input, HoursStr), atom_number(HoursStr, Hours),
    write('Enter Overtime Hours: '), flush_output,
    read_line_to_string(user_input, OT_HoursStr), atom_number(OT_HoursStr, OT_Hours),
    write('Enter Deductions: '), flush_output,
    read_line_to_string(user_input, DeductionsStr), atom_number(DeductionsStr, Deductions),
    GrossPay is (Hours * Rate) + (OT_Hours * Rate * 1.5),
    assertz(employee(EmpID, Name, DateHired, Dept, Position, Status, Rate, Hours, OT_Hours, Deductions, GrossPay)),
    write('Employee added successfully!'), nl.

edit_employee :-
    nl, write('Enter Employee ID to Edit: '), flush_output,
    read_line_to_string(user_input, EmpIDStr), atom_number(EmpIDStr, EmpID),
    (   retract(employee(EmpID, _, _, _, _, _, _, _, _, _, _))
    ->  write('Enter New Name: '), flush_output, read_line_to_string(user_input, Name),
        write('Enter New Date Hired (YYYY-MM-DD): '), flush_output, read_line_to_string(user_input, DateHired),
        write('Enter New Department: '), flush_output, read_line_to_string(user_input, Dept),
        write('Enter New Position: '), flush_output, read_line_to_string(user_input, Position),
        write('Enter New Employment Status: '), flush_output, read_line_to_string(user_input, Status),
        write('Enter New Rate per Hour: '), flush_output, read_line_to_string(user_input, RateStr), atom_number(RateStr, Rate),
        write('Enter New Hours Worked: '), flush_output, read_line_to_string(user_input, HoursStr), atom_number(HoursStr, Hours),
        write('Enter New Overtime Hours: '), flush_output, read_line_to_string(user_input, OT_HoursStr), atom_number(OT_HoursStr, OT_Hours),
        write('Enter New Deductions: '), flush_output, read_line_to_string(user_input, DeductionsStr), atom_number(DeductionsStr, Deductions),
        GrossPay is (Hours * Rate) + (OT_Hours * Rate * 1.5),
        assertz(employee(EmpID, Name, DateHired, Dept, Position, Status, Rate, Hours, OT_Hours, Deductions, GrossPay)),
        write('Employee record updated!'), nl
    ;   write('Employee ID not found!'), nl
    ).

delete_employee :-
    nl, write('Enter Employee ID to Delete: '), flush_output,
    read_line_to_string(user_input, EmpIDStr), atom_number(EmpIDStr, EmpID),
    (   retract(employee(EmpID, _, _, _, _, _, _, _, _, _, _))
    ->  write('Employee record deleted!'), nl
    ;   write('Employee ID not found!'), nl
    ).

compute_salary :-
    nl, write('Enter Employee ID to Compute Salary: '), flush_output, 
    read_line_to_string(user_input, EmpIDStr), atom_number(EmpIDStr, EmpID),
    (   employee(EmpID, Name, _, _, _, _, Rate, Hours, OT_Hours, Deductions, GrossPay)
    ->  NetSalary is GrossPay - Deductions,
        OvertimePay is OT_Hours * Rate * 1.5,
        write('Employee: '), write(Name), nl,
        write('Rate per Hour: PHP '), write(Rate), nl,
        write('Regular Hours: '), write(Hours), nl,
        write('Overtime Hours: '), write(OT_Hours), nl,
        write('Overtime Pay: PHP '), write(OvertimePay), nl,
        write('Gross Pay: PHP '), write(GrossPay), nl,
        write('Deductions: PHP '), write(Deductions), nl,
        write('Net Salary: PHP '), write(NetSalary), nl
    ;   write('Employee ID not found!'), nl
    ).

display_employee :-
    nl, write('Enter Employee ID to View: '), flush_output,
    read_line_to_string(user_input, EmpIDStr), atom_number(EmpIDStr, EmpID),
    (   employee(EmpID, Name, DateHired, Dept, Position, Status, Rate, Hours, OT_Hours, Deductions, _)
    ->  write('Employee Details:'), nl,
        write('ID: '), write(EmpID), nl,
        write('Name: '), write(Name), nl,
        write('Date Hired: '), write(DateHired), nl,
        write('Department: '), write(Dept), nl,
        write('Position: '), write(Position), nl,
        write('Employment Status: '), write(Status), nl,
        write('Rate per Hour: PHP '), write(Rate), nl,
        write('Hours Worked: '), write(Hours), nl,
        write('Overtime Hours: '), write(OT_Hours), nl,
        write('Deductions: PHP '), write(Deductions), nl
    ;   write('Employee ID not found!'), nl
    ).

save_records :-
    nl, write('Enter filename to save (without .pl): '), flush_output,
    read_line_to_string(user_input, FileStr),
    atom_concat(FileStr, '.pl', FileName),
    tell(FileName),
    listing(employee),
    told,
    write('Records saved successfully!'), nl.

load_records :-
    nl, write('Enter filename to load: '), flush_output,
    read_line_to_string(user_input, FileStr),
    atom_concat(FileStr, '.pl', FileName),
    (   exists_file(FileName)
    ->  consult(FileName),
        write('Records loaded successfully!'), nl
    ;   write('File not found!'), nl
    ).