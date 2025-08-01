console.log("\033c\033[40;33m\n")

const fs = require('fs');
const path = require('path');
const wasmBuffer = fs.readFileSync(path.join(__dirname, 'main.wasm'));
WebAssembly.instantiate(wasmBuffer).then(wasmModule => {
	const { eeppromX } = wasmModule.instance.exports;
	var d=0;
	var e=0;
	
	e=eeppromX(0,0);
	for(d=0;d<e;d++)console.log(eeppromX(d+1,0));

});