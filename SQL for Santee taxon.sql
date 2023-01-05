SELECT DISTINCT mapunit.musym AS musym, mapunit.muname AS muname, mapunit.mukind AS mukind, mapunit.mukey, component.cokey,
component.compname AS compname, component.compkind AS compkind, component.majcompflag AS majorcomp,
component.geomdesc AS geomdesc, component.hydgrp AS hydroGroup,
component.taxclname AS taxonClass, component.taxorder AS taxOrder,
component.taxsuborder AS taxSuborder, component.taxgrtgroup AS GreatGroup,
component.taxsubgrp AS Subgroup, component.taxpartsize AS ParticleSize, legend.lkey, legend.areaname, legend.areasymbol

FROM component, mapunit, legend


WHERE legend.lkey = mapunit.lkey
	AND component.mukey = mapunit.mukey
	AND mapunit.mukey IN ('131960', 
'131963',
'131952',
'131967',
'131961',
'131939',
'131949',
'131953',
'131957',
'131965',
'131956',
'131969',
'131974',
'131954',
'131976',
'131940',
'131962',
'131955',
'131941',
'131958')
	
ORDER BY mapunit.musym;
	