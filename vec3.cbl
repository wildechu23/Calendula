       identification division.
       program-id. vec-add.

       data division.
       linkage section.
       01 vec1.
           05 vec1-a comp-2 occurs 3 times.
       01 vec2.
           05 vec2-a comp-2 occurs 3 times.

       procedure division 
           using by reference vec1 vec2.
           add vec2-a(1) to vec1-a(1)
           add vec2-a(2) to vec1-a(2)
           add vec2-a(3) to vec1-a(3)
           goback.
           end program vec-add.

       identification division.
       program-id. vec-sub.

       data division.
       linkage section.
       01 vec1.
           05 vec1-a comp-2 occurs 3 times.
       01 vec2.
           05 vec2-a comp-2 occurs 3 times.

       procedure division
           using by reference vec1 vec2.
           subtract vec2-a(1) from vec1-a(1)
           subtract vec2-a(2) from vec1-a(2)
           subtract vec2-a(3) from vec1-a(3)
           goback.
           end program vec-sub.
           

       identification division.
       program-id. vec-mul.

       data division.
       linkage section.
       01 vec1.
           05 vec1-a comp-2 occurs 3 times.
       01 vec2. 
           05 vec2-a comp-2 occurs 3 times.

       procedure division 
           using by reference vec1 vec2.
           multiply vec2-a(1) by vec1-a(1)
           multiply vec2-a(2) by vec1-a(2)
           multiply vec2-a(3) by vec1-a(3)
           goback.
           end program vec-mul.
       
       identification division.
       program-id. vec-div.

       data division.
       linkage section.
       01 vec1.
           05 vec1-a comp-2 occurs 3 times.
       01 vec2.
           05 vec2-a comp-2 occurs 3 times.

       procedure division 
           using by reference vec1 vec2.
           divide vec2-a(1) into vec1-a(1)
           divide vec2-a(2) into vec1-a(2)
           divide vec2-a(3) into vec1-a(3)
           goback.
           end program vec-div.

       identification division.
       program-id. scale.

       data division.
       linkage section.
       01 vec.
           05 vec-a comp-2 occurs 3 times.
       01 t comp-2.

       procedure division
           using by reference vec t.
           multiply t by vec-a(1)
           multiply t by vec-a(2)
           multiply t by vec-a(3)
           goback.
           end program scale.

       identification division.
       function-id. dot.

       data division.
       linkage section.
       01 vec1.
           05 vec1-a comp-2 occurs 3 times.
       01 vec2.
           05 vec2-a comp-2 occurs 3 times.
       01 dot-product comp-2.

       procedure division
           using vec1 vec2
           returning dot-product.
           compute dot-product = vec1-a(1) * vec2-a(1) +
               vec1-a(2) * vec2-a(2) + vec1-a(3) * vec2-a(3)
           goback.
           end function dot.

       identification division.
       function-id. norm.

       environment division.
       configuration section.
       repository.
           function dot.

       data division.
       linkage section.
       01 vec.
           05 vec-a comp-2 occurs 3 times.
       01 norm-result comp-2.

       procedure division
           using vec
           returning norm-result.
           compute norm-result = function sqrt(dot(vec, vec))
           goback.
           end function norm.

       identification division.
       function-id. cross.

       data division.
       linkage section.
       01 vec1.
           05 vec1-a comp-2 occurs 3 times.
       01 vec2.
           05 vec2-a comp-2 occurs 3 times.
       01 vec3.
           05 vec3-a comp-2 occurs 3 times.

       procedure division
           using vec1 vec2
           returning vec3.
           compute vec3-a(1) = vec1-a(2) * vec2-a(3) -
           vec1-a(3) * vec2-a(2)
           compute vec3-a(2) = vec1-a(3) * vec2-a(1) -
           vec1-a(1) * vec2-a(3)
           compute vec3-a(3) = vec1-a(1) * vec2-a(2) -
           vec1-a(2) * vec2-a(1)
           goback.
           end function cross.

       identification division.
       function-id. unit-vector.

       environment division.
       configuration section.
       repository.
           function norm.

       data division.
       working-storage section.
       01 t comp-2.
       
       linkage section.
       01 vec1.
           05 vec1-a comp-2 occurs 3 times.
       01 vec2.
           05 vec2-a comp-2 occurs 3 times.

       procedure division
           using vec1
           returning vec2.
           compute t = 1 / norm(vec1)
           move vec1 to vec2
           call 'scale' using vec2 t
           goback.
           end function unit-vector.

