# 6 - Abstract DataType

derivar 4x^2.y^5.z^6 y = 20x^1.y^4.z^6

prod num factor = num * factor
prod (mono, simbol, expo) factor = [prod mono factor, simbol expo]

derivarAux (num, simbol, expo) letter = if simbol == letter then [num*expo, simbol, expo-1] else [] // base case
derivarAux (mono, simbol, expo) letter = if simbol == letter then [(), simbol, expo-1] else [derivarAux mono, simbol, expo]

derivar poli letter = [derivarAux mono letter | mono <- poli]