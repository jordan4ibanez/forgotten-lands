namespace utility {

  /**
   * Mini null safety wrapper.
   * Since this is single threaded, it's gonna get real weird.
   */
  export class OptionSingleThreaded<T> {
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

    someFunction<T>(f: (input: T) => void): OptionSingleThreaded<T> {
      if (this.data != null) {
        f(this.data as T);
      }
      return this as unknown as OptionSingleThreaded<T>;
    }

    noneFunction<T>(f: () => void): OptionSingleThreaded<T> {
      if (this.data == null) {
        f();
      }
      return this as unknown as OptionSingleThreaded<T>;
    }

    constructor(input: T | null) {
      this.data = input;
    }

    mutate<Y>(input: Y | null): OptionSingleThreaded<Y> {
      (this.data as Y | null) = input;
      return this as unknown as OptionSingleThreaded<Y>;
    }
  }

  // Brute force memory optimization in this single threaded environment.
  let singleton = new OptionSingleThreaded<any>(null);

  /**
   * If you're not sure if it's going to be nothing, safely wrap it.
   * ! Do not use this in a threaded environment or it WILL explode. :D
   * @param input Something...or maybe nothing?
   * @returns OptionSingleThreaded<Type>
   */
  export function optionWrap<T>(input: T | null): OptionSingleThreaded<T> {
    return singleton.mutate(input);
  }
}