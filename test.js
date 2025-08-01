console.log("\033c\033[40;33m\n")
const fs = require('fs');
const path = require('path');

const wasmPath = path.join(__dirname, 'main.wasm');
const buffer = fs.readFileSync(wasmPath);

WebAssembly.instantiate(buffer).then(result => {
    const { exports } = result.instance;
    e=exports.sum(0, 0)
    for(i=1;i<e;i++)console.log(exports.sum(i, 0));
});