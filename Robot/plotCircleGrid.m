function plotCircleGrid(inner,outer,sidespoly,indivisions)
M = indivisions ;
N = sidespoly+1 ;
R1 = inner ; % inner radius 
R2 = outer ;  % outer radius
nR = linspace(R1,R2,M) ;
nT = linspace(0,2*pi,N) ;
%nT = pi/180*(0:NT:theta) ;
[R, T] = meshgrid(nR,nT) ;
% Convert grid to cartesian coordintes
X = R.*cos(T); 
Y = R.*sin(T);
[m,n]=size(X);
% Plot grid
%figure
%set(gcf,'color','w') ;
axis equal
axis off
box on
hold on
% Plot internal grid lines
for i=1:m
    plot(X(i,:),Y(i,:),'k','linewidth',0.5); 
end
for j=1:n
    plot(X(:,j),Y(:,j),'k','linewidth',0.5); 
end