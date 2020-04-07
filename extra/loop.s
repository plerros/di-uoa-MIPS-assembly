loop:
#code...
	bltz	$v0,loop	#if v0 < 0, loop
	beq	$v0,$t0,loop	#if v0 = t0, loop
	bne	$v0,$t0,loop	#if v0 != t0, loop
	