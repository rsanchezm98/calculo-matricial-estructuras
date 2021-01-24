## Cálculo matricial de estructuras en MATLAB
Este programa en MATLAB permite:
* Obtener matrices de rigidez locales, globales. 
* Ensamblar las matrices globales de cada barra en la matriz de rigidez global del sistema. 
* Obtener desplazamientos del sistema en locales y globales de cada nudo. 
* Obtener esfuerzos en locales y globales de cada barra.
* Reacciones en los nudos. 
* Obtener esfuerzos y fuerzas térmicas aplicados sobre la barra.
* Ploteado de la matriz de rigidez ensamblada con los términos correspondientes independientes y necesarios para el cálculo matricial.

    ![alt text](https://github.com/rsanchezm98/calculo-matricial-estructuras/blob/mejora-1/imagenes/matriz-ensamblada.PNG)

# Lanzamiento del programa
1. Introducir los datos en el archivo [ensamblaje.m](https://github.com/rsanchezm98/calculo-matricial-estructuras/blob/main/ensamblaje.m) y lanzar el archivo. Se obtendrá la matriz de rigidez global ensamblada, las globales de cada barra y la matriz de rigidez reducida ensamblada de acuerdo a los desplazamientos no nulos independientes. 
2. Introducir el vector de fuerzas en el archivo [esfuerzosLocales.m](https://github.com/rsanchezm98/calculo-matricial-estructuras/blob/main/esfuerzosLocales.m). Se debe incluir también la superposición de esfuerzos en locales de cada barra en el final del código. De esta manera se tiene: desplazamientos no nulos, esfuerzos en las barras en locales sin superponer y superpuestos. 
3. Lanzar el archivo [ReaccionesNudos.m](https://github.com/rsanchezm98/calculo-matricial-estructuras/blob/main/ReaccionesNudos.m) para obtener las reacciones en los nudos en globales. 

# Dudas y aportaciones
Cualquier duda y aportación, ponerse en contacto con **Rodrigo Sánchez Molina** - [rsanchezm98](https://github.com/rsanchezm98)
