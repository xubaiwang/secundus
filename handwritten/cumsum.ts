// setup memories
const inputMemory = new WebAssembly.Memory({ initial: 1 });
const outputMemory = new WebAssembly.Memory({ initial: 1 });
new Float32Array(inputMemory.buffer).set([1, 2, 3]);

// wasm module
const { instance } = await WebAssembly.instantiateStreaming(
  fetch(new URL("./cumsum.wasm", import.meta.url)),
  {
    env: {
      inputMemory,
      outputMemory,
    },
  },
);

// call
const cumsum = instance.exports.cumsum as (_: number) => void;
cumsum(3);

// show result
console.log({
  input: new Float32Array(inputMemory.buffer, 0, 3),
  output: new Float32Array(outputMemory.buffer, 0, 3),
});
// Output:
// {
//   input: Float32Array(3) [ 1, 2, 3 ],
//   output: Float32Array(3) [ 1, 3, 6 ]
// }
