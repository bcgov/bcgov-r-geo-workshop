## Intro to Vector lessons:

1. dplyr (15 min):

    - hoping most people will have seen it, so high-level quick overview
    - slides only
    - basic verbs: filter, select, mutate, group_by, summarize
    - may need to introduce joins later, but do it on the fly

2. Into to sf + basic mapping (90 min)

    1. Fundamentals (20 min):
        - Read a single gdb
        - Introduction to simple features
          - structure of sf object
          - different geometry types
        - mapview use (zcol)
        - crs/epsg etc
    2. Intro to sf package (40 min):
       *Demonstrate dplyr verbs with reading demos*
        - Reading data
            - read in spatial data (gdb, shp, gpkg)
                - for gdb, gpkg show multi-layer files
            - read in tabular 'spatial' data 
                - example csv lat/long - (read.csv or st_read??)
                - example with csv with UTM (zone etc in crs)
            - read in data using bcdata - using only `bcdc_get_data()` & simple `bcdc_query_geodata()`
        - Intro to plotting with ggplot2 with single layer (on second and subsequent read example)
        - transformations (could do crs intro here instead of in Fundamentals)
        - group_by + summarize - highlight aggregating features on different attributes
            - Functions: st_area, st_length, st_centroid, etc.

*** Coffee Break (15 min) ***

3. Plotting part 2 (10 min):

    - multiple layers

4. Spatial operations (35 min):

    1. geometry generating logical operators

        * `st_union`: union of several geometries
        * `st_intersection`: intersection of pairs of geometries
        * `st_difference`: difference between pairs of geometries
        * `st_sym_difference`: symmetric difference (`xor`)

    2. logical binary geometry predicates

        * `st_intersects`: touch or overlap
        * `st_disjoint`: !intersects
        * `st_touches`: touch
        * `st_crosses`: cross (don't touch)
        * `st_within`: within
        * `st_contains`: contains
        * `st_overlaps`: overlaps
        * `st_covers`: cover
        * `st_covered_by`: covered by
        * `st_equals`: equals
        * `st_equals_exact`: equals, with some fuzz

    3. higher-level operations: summarise, interpolate, aggregate, st_join

        * `aggregate` and `summarise` use `st_union` (by default) to group feature geometries
        * `st_interpolate_aw`: area-weighted interpolation, uses `st_intersection` to interpolate or redistribute attribute values, based on area of overlap:
        * `st_join` uses one of the logical binary geometry predicates (default: `st_intersects`) to join records in table pairs

    4. manipulating geometries

        * `st_line_merge`: merges lines
        * `st_segmentize`: adds points to straight lines
        * `st_voronoi`: creates voronoi tesselation
        * `st_centroid`: gives centroid of geometry
        * `st_convex_hull`: creates convex hull of set of points
        * `st_triangulate`: triangulates set of points (not constrained)
        * `st_polygonize`: creates polygon from lines that form a closed ring
        * `st_simplify`: simplifies lines by removing vertices
        * `st_split`: split a polygon given line geometry
        * `st_buffer`: compute a buffer around this geometry/each geometry
        * `st_make_valid`: tries to make an invalid geometry valid (requires lwgeom)
        * `st_boundary`: return the boundary of a geometry

5. Plotting part 3 (30 min):

    - transforming, coord_sf
    - making nice maps
    - ggspatial for north arrow and scale bar
