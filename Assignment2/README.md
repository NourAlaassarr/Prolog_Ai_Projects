Assignment 2 [6 marks]
Search algorithms can solve the "Dominoes Puzzle" problem easily, so you are required to
implement one uninformed search technique and one informed search technique to solve this
puzzle in Prolog.
Part 1 - Uninformed Search:
● You are given a rectangular board of size M × N.
● Also, you are given an unlimited number of domino pieces ( ) of 2 × 1 cells each.
● There are 2 bomb cells ( ) on the board, each bomb cell is of a 1 × 1 square.
● You are asked to place dominoes on the board so as to meet the following conditions:
1. Each domino piece completely covers two squares. (You are allowed to rotate the
domino pieces)
2. No two dominoes overlap.
3. Each domino lies entirely inside the board. It is allowed to touch the edges of the
board and not allowed to lie on the bomb cell.
Examples:
Input:
● 3x3 Board (as shown in the figure below)
● Position of bombs (1,3) and (2,1)
Output(s):
And so on…
Input:
● 2x4 Board (as shown in the figure below)
● Position of bombs (2,2) and (2,3)
Output(s):
And so on…
Part 2 - Informed Search:
For the dominoes puzzle, find the maximum number of dominoes which can be placed.
Examples:
Input:
● 3x3 Board (as shown in the figure below)
● Position of bombs (1,3) and (2,1)
Output(s):
3 is maximum number of dominoes that can be placed.
Input:
● 2x4 Board (as shown in the figure below)
● Position of bombs (2,2) and (2,3)
Output(s):
3 is maximum number of dominoes that can be placed.
Problem Components:
This program consists of the following engine:
● Planner Engine (responsible for the following)
○ Taking the query entered by the user in Prolog.
○ Applying the planning algorithm using one of the uninformed search algorithms in
part 1 and an informed search algorithm in part 2 to get the path. (Search
algorithms should be implemented using an open list and a closed list)
