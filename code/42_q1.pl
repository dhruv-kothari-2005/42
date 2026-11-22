:- use_module(library(lists)).
% Generates all possible assignments with every attribute value used exactly once.
generate_solution(Solution) :-
    Departments = [research, development, design, testing],
    Languages = [python, java, 'c++', javascript],
    Projects = ['AI', web, embedded, data],

    permutation(Departments, [AlexDept, BenDept, CarlaDept, DanaDept]),
    permutation(Languages, [AlexLang, BenLang, CarlaLang, DanaLang]),
    permutation(Projects, [AlexProject, BenProject, CarlaProject, DanaProject]),

    Solution = [
        p('Alex', AlexDept, AlexLang, AlexProject),
        p('Ben', BenDept, BenLang, BenProject),
        p('Carla', CarlaDept, CarlaLang, CarlaProject),
        p('Dana', DanaDept, DanaLang, DanaProject)
    ].

% Clue 1: The person who prefers AI does not work in research and is not Dana.
clue(1, Solution) :-
    member(p(Name, Dept, _, 'AI'), Solution),
    Dept \= research,
    Name \= 'Dana'.

% Clue 2: Alex does not work in development and does not prefer C++.
clue(2, Solution) :-
    member(p('Alex', Dept, Lang, _), Solution),
    Dept \= development,
    Lang \= 'c++'.

% Clue 3: The person working in testing likes Python.
clue(3, Solution) :-
    member(p(_, testing, python, _), Solution).

% Clue 4: Ben prefers web projects and does not work in testing.
clue(4, Solution) :-
    member(p('Ben', Dept, _, web), Solution),
    Dept \= testing.

% Clue 5: The person whose favorite language is Java works in the design department.
clue(5, Solution) :-
    member(p(_, design, java, _), Solution).

% Clue 6: Carla project preference is not embedded, and her department is not development.
clue(6, Solution) :-
    member(p('Carla', Dept, _, Project), Solution),
    Project \= embedded,
    Dept \= development.
    
% Clue 7: Dana's favorite language is not Java, and she works in research or testing.
clue(7, Solution) :-
    member(p('Dana', Dept, Lang, _), Solution),
    Lang \= java,
    (Dept = research ; Dept = testing).
    
% Clue 8: The person who prefers data projects works in research and does not use JavaScript.
clue(8, Solution) :-
    member(p(_, research, Lang, data), Solution),
    Lang \= javascript.
    
 






