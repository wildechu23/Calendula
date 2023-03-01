       id division.
       program-id. calendula.

       environment division.
       configuration section.
       repository.
           function dot
           function norm
           function unit-vector.

       input-output section.
       file-control.
           select header assign to 'image.ppm'
               organization is sequential.
           select p3-image assign to 'image.ppm'
               organization is line sequential.
           select p6-image assign to 'image.ppm'
               organization is sequential.

       data division.
       file section.
       fd header.
       01 header-file.
           05 p-type pic x(3).
           05 dims pic x(10).
           05 maxval pic x(5).
       fd p3-image.
       01 p3-image-file.
           05 p3-image-rgb pic x(11).
       fd p6-image.
       01 p6-image-file.
           05 p6-image-a binary-char occurs 3 times.

       working-storage section.
       01 width pic 9(4) value 400.
       01 height pic 9(4).
       01 width-d pic z(4).
       01 height-d pic z(4).
       01 aspect-ratio comp-2.

       01 viewport-height comp-2 value 2.
       01 viewport-width comp-2.
       01 focal-length comp-2 value 1.

       01 origin.
           05 origin-a comp-2 value 0 occurs 3 times.
       01 horizontal.
           05 horizontal-a comp-2 value 0 occurs 3 times.
       01 vertical.
           05 vertical-a comp-2 value 0 occurs 3 times.
       01 lower-left.
           05 lower-left-a comp-2 occurs 3 times.


       01 i pic 9(4).
       01 j pic 9(4).
       01 red pic 9(3).
       01 green pic 9(3).
       01 blue pic 9(3).

       01 vec.
           05 vec-a comp-2 occurs 3 times.
       01 scale comp-2 value 255.


       procedure division.
       main section.
           compute aspect-ratio = 16/9
           compute height = width / aspect-ratio
           compute viewport-width = aspect-ratio * viewport-height
           move viewport-width to horizontal-a(1)
           move viewport-height to vertical-a(2)

           move viewport-width to lower-left-a(1)
           multiply -0.5 by lower-left-a(1)
           move viewport-height to lower-left-a(2)
           multiply -0.5 by lower-left-a(2)
           multiply -1 by focal-length giving lower-left-a(3)
           display lower-left-a(1)' 'lower-left-a(2)' 'lower-left-a(3)
           end-display
           
           move width to width-d
           move height to height-d
      *>perform output-p3
           perform p6-header
           open extend p6-image
           perform varying i from 0 by 1 until i = height
               display 'Scanline: 'i end-display
               perform varying j from 0 by 1 until j = width
                   compute vec-a(1) = i / (height - 1)
                   compute vec-a(2) = j / (width - 1)
                   compute vec-a(3) = 0.25
                   perform write-p6
               end-perform
           end-perform
           close p6-image
           goback.

       p6-header section.
           move 'P6' & x'0a' to p-type
           move function concatenate(
               function trim(width-d, leading), space,
               function trim(height-d, leading)
            ) to dims
           move x'0a' & '255' & x'0a' to maxval
           open output header
           write header-file end-write
           close header.

       write-p6 section.
           call 'scale' using vec scale
           move vec-a(1) to p6-image-a(1)
           move vec-a(2) to p6-image-a(2)
           move vec-a(3) to p6-image-a(3)
           write p6-image-file end-write.

       output-p3 section.
           move 'P3' & x'0a' to p-type
           move function concatenate(
               function trim(width-d, leading), space,
               function trim(height-d, leading)
            ) to dims
           move x'0a' & '255' & x'0a' to maxval
           open output header
           write header-file end-write
           close header
           open extend p3-image
           perform varying i from 0 by 1 until i = height
               after j from 0 by 1 until j = width
                   compute red = 255 * i / (height - 1)
                   compute green = 255 * j / (width - 1)
                   compute blue = 255 * 0.25
                   move function concatenate(
                       red, space, 
                       green, space,
                       blue
                    ) to p3-image-rgb
                   write p3-image-file end-write
           end-perform
           close p3-image.

