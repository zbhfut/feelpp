h = 0.05;
Point(1) = {-1.0, -1, 0, h};
Point(2) = {-1.0,  1, 0, h};
Point(3) = { 1.0,  1, 0, h};
Point(4) = { 1.0, -1, 0, h};
Line(1+4) = {1, 4};
Line(2+4) = {4, 3};
Line(3+4) = {3, 2};
Line(4+4) = {2, 1};
Line Loop(9) = {5,6,7,8};
Physical Line("Border") = {5,6,7,8};
Plane Surface(10) = {9};
Physical Surface("Omega") = {10};
