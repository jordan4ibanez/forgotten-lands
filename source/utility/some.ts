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
}