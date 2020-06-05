function [respuesta] = vista(Robot,lista)

for j = 1:5
    posicion = Robot.Posicion;
   if posicion(1) > lista(j,1) - 0.5 &&  posicion(1)  < lista(j,1) + 0.5
       if posicion(2)  > lista(j,2) - 0.5 &&  posicion(2) < lista(j,2) + 0.5
           respuesta = false;
           break
       else
           respuesta = true;
       end
   else
       respuesta = true;
   end
end

end