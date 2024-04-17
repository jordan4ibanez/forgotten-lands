namespace utility {

  /**
   * Mini null safety wrapper 
   */
  export class Option<T> {
    data: T | null = null

    is_some(): boolean {
      return (this.data != null);
    }

    is_none(): boolean {
      return (this.data == null);
    }

    unwrap(): T {
      if (this.data) {
        return this.data;
      } else {
        error("Tried to unwrap nothing!");
      }
    }

    constructor(input: T | null) {
      if (input) {
        this.data = input;
      }
    }
  }

  /**
   * If you're not sure if it's going to be nothing, safely wrap it.
   * @param input Something...or maybe nothing?
   * @returns Option<Type>
   */
  export function optionWrap<T>(input: T | null): Option<T> {
    return new Option<T>(input);
  }
}