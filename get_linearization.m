function [A,B] = get_linearization(eq,params)

g = params.g;
M = params.M;
m = params.m;
c = params.c;
l = params.l;
sigma = params.sigma;

if strcmp(eq,'0')
    
%     A =  [ 0    1       0            0         ; ...
%         0    -c/M    g*m/M       -sigma/M/l   ; ...
%         0    0       0            1         ;...
%         0    -c/M/l  (M+m)*g/M/l  -sigma*(M+m)/M/m/(l^2)   ];
    
    A =  [ 0    1       0            0         ; ...
           0    -c/M    g*m/M        0   ; ...
           0    0       0            1         ;...
           0    -c/M/l  (M+m)*g/M/l  -sigma/m/(l^2)   ];
    
    B  = [ 0     ; ...
        1/M ; ...
        0     ; ...
        1/M/l ];
    
end

if strcmp(eq,'pi')
    
%     A =  [ 0    1       0            0         ; ...
%         0    -c/M    g*m/M        sigma/M/l   ; ...
%         0    0       0            1         ;...
%         0    c/M/l  -(M+m)*g/M/l  -sigma*(M+m)/M/m/(l^2)   ];
    
    A =  [ 0    1       0            0         ; ...
        0    -c/M    g*m/M        0   ; ...
        0    0       0            1         ;...
        0    c/M/l  -(M+m)*g/M/l  -sigma/m/(l^2)   ];
    
    B  = [ 0     ; ...
        1/M ; ...
        0     ; ...
        -1/M/l ];
    
end