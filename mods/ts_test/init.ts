
export {}

let x = 5;

declare global {
  /** @noSelf **/
  function ye(): void
}

globalThis.ye = function() {

}

print("HELLO, FROM TS!")