;;; Generated automatically. Do not edit.
;;; Class: System.IO.TextReader
;;; Generator Version: 51
;;; Creation Date: 2026-07-19T15:11:53Z

(cl:in-package :system-io-text-reader)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.IO.TextReader"))
(cl:defconstant <type-str> "System.IO.TextReader")
(cl:defconstant <creation> "2026-07-19T15:11:53Z")
(cl:defconstant <version> 51)

(cl:defun new ()
  "Summary: Initializes a new instance of the System.IO.TextReader class.
"
  (dotnet:new <type-str>))

(cl:define-symbol-macro null (dotnet:static <type-str> "Null"))
(cl:setf (cl:documentation (cl:quote null) (cl:quote cl:variable)) "Provides a with no data to read from.")

(cl:defun close (obj!)
  "Summary: Closes the System.IO.TextReader and releases any system resources associated with the .
"
  (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "Close"))

(cl:defun dispose (obj! cl:&optional (disposing cl:nil supplied-disposing))
  "Master wrapper for System.IO.TextReader.Dispose overloads. Dispatches at runtime.

Dispose() -> Void
  Summary: Releases all resources used by the System.IO.TextReader object.

Dispose(Boolean) -> Void
  Summary: Releases the unmanaged resources used by the System.IO.TextReader and optionally releases the managed resources.
  Parameters:
    - disposing (System.Boolean): to release both managed and unmanaged resources; to release only unmanaged resources.
"
  (cl:cond
    ((cl:and supplied-disposing (cl:typep disposing 'cl:boolean))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "Dispose" disposing))
    ((cl:and (cl:not supplied-disposing))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "Dispose"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-TEXT-READER"
                    :class-name <type-str>
                    :method-name "Dispose"
                    :supplied-args (cl:append (cl:when supplied-disposing (cl:list :disposing disposing)))))))

(cl:defun peek (obj!)
  "Summary: Reads the next character without changing the state of the reader or the character source. Returns the next available character without actually reading it from the reader.
Returns: An integer representing the next character to be read, or -1 if no more characters are available or the reader does not support seeking.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "Peek"))

(cl:defun read (obj! cl:&optional (buffer cl:nil supplied-buffer) (index cl:nil supplied-index) (count cl:nil supplied-count))
  "Master wrapper for System.IO.TextReader.Read overloads. Dispatches at runtime.

Read() -> Int32
  Summary: Reads the next character from the text reader and advances the character position by one character.
  Returns: The next character from the text reader, or -1 if no more characters are available. The default implementation returns -1.

Read(Char]) -> Int32
  Summary: Reads the characters from the current reader and writes the data to the specified buffer.
  Returns: The number of characters that have been read. The number will be less than or equal to the buffer length, depending on whether the data is available within the reader. This method returns 0 (zero) if it is called when no more characters are left to read.
  Parameters:
    - buffer (System.Span`1[System.Char]): When this method returns, contains the specified span of characters replaced by the characters read from the current source.

Read(Char[], Int32, Int32) -> Int32
  Summary: Reads a specified maximum number of characters from the current reader and writes the data to a buffer, beginning at the specified index.
  Returns: The number of characters that have been read. The number will be less than or equal to count, depending on whether the data is available within the reader. This method returns 0 (zero) if it is called when no more characters are left to read.
  Parameters:
    - buffer (System.Char[]): When this method returns, contains the specified character array with the values between index and (index + count - 1) replaced by the characters read from the current source.
    - index (System.Int32): The position in buffer at which to begin writing.
    - count (System.Int32): The maximum number of characters to read. If the end of the reader is reached before the specified number of characters is read into the buffer, the method returns.
"
  (cl:cond
    ((cl:and supplied-buffer (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Char[]")) supplied-index (cl:numberp index) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "Read" buffer index count))
    ((cl:and supplied-buffer (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Span`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "Read" buffer))
    ((cl:and (cl:not supplied-buffer) (cl:not supplied-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "Read"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-TEXT-READER"
                    :class-name <type-str>
                    :method-name "Read"
                    :supplied-args (cl:append (cl:when supplied-buffer (cl:list :buffer buffer)) (cl:when supplied-index (cl:list :index index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun read-async (obj! buffer cancellation-token cl:&optional (count cl:nil supplied-count))
  "Master wrapper for System.IO.TextReader.ReadAsync overloads. Dispatches at runtime.

ReadAsync(Char], CancellationToken = default(System.Threading.CancellationToken) [C# default of type System.Threading.CancellationToken -- not representable in Lisp, must be supplied]) -> Int32]
  Summary: Asynchronously reads the characters from the current stream into a memory block.
  Returns: A value task that represents the asynchronous read operation. The value of the type parameter contains the number of characters that have been read, or 0 if at the end of the stream and no data was read. The number will be less than or equal to the buffer length, depending on whether the data is available within the stream.
  Parameters:
    - buffer (System.Memory`1[System.Char]): When this method returns, contains the specified memory block of characters replaced by the characters read from the current source.
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests. The default value is System.Threading.CancellationToken.None.

ReadAsync(Char[], Int32, Int32) -> Int32]
  Summary: Reads a specified maximum number of characters from the current text reader asynchronously and writes the data to a buffer, beginning at the specified index.
  Returns: A task that represents the asynchronous read operation. The value of the TResult parameter contains the total number of bytes read into the buffer. The result value can be less than the number of bytes requested if the number of bytes currently available is less than the requested number, or it can be 0 (zero) if the end of the text has been reached.
  Parameters:
    - buffer (System.Char[]): When this method returns, contains the specified character array with the values between index and (index + count - 1) replaced by the characters read from the current source.
    - index (System.Int32): The position in buffer at which to begin writing.
    - count (System.Int32): The maximum number of characters to read. If the end of the text is reached before the specified number of characters is read into the buffer, the current method returns.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Char[]")) (cl:numberp cancellation-token) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "ReadAsync" buffer cancellation-token count))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Memory`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null cancellation-token) (dotnet:is-instance-of cancellation-token "System.Threading.CancellationToken")) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "ReadAsync" buffer cancellation-token))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-TEXT-READER"
                    :class-name <type-str>
                    :method-name "ReadAsync"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:list :cancellation-token cancellation-token) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun read-block (obj! buffer cl:&optional (index cl:nil supplied-index) (count cl:nil supplied-count))
  "Master wrapper for System.IO.TextReader.ReadBlock overloads. Dispatches at runtime.

ReadBlock(Char]) -> Int32
  Summary: Reads the characters from the current stream and writes the data to a buffer.
  Returns: The number of characters that have been read. The number will be less than or equal to the buffer length, depending on whether all input characters have been read.
  Parameters:
    - buffer (System.Span`1[System.Char]): When this method returns, contains the specified span of characters replaced by the characters read from the current source.

ReadBlock(Char[], Int32, Int32) -> Int32
  Summary: Reads a specified maximum number of characters from the current text reader and writes the data to a buffer, beginning at the specified index.
  Returns: The number of characters that have been read. The number will be less than or equal to count, depending on whether all input characters have been read.
  Parameters:
    - buffer (System.Char[]): When this method returns, this parameter contains the specified character array with the values between index and (index + count -1) replaced by the characters read from the current source.
    - index (System.Int32): The position in buffer at which to begin writing.
    - count (System.Int32): The maximum number of characters to read.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Char[]")) supplied-index (cl:numberp index) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "ReadBlock" buffer index count))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Span`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "ReadBlock" buffer))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-TEXT-READER"
                    :class-name <type-str>
                    :method-name "ReadBlock"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:when supplied-index (cl:list :index index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun read-block-async (obj! buffer cancellation-token cl:&optional (count cl:nil supplied-count))
  "Master wrapper for System.IO.TextReader.ReadBlockAsync overloads. Dispatches at runtime.

ReadBlockAsync(Char], CancellationToken = default(System.Threading.CancellationToken) [C# default of type System.Threading.CancellationToken -- not representable in Lisp, must be supplied]) -> Int32]
  Summary: Asynchronously reads the characters from the current stream and writes the data to a buffer.
  Returns: A value task that represents the asynchronous read operation. The value of the type parameter contains the total number of characters read into the buffer. The result value can be less than the number of characters requested if the number of characters currently available is less than the requested number, or it can be 0 (zero) if the end of the stream has been reached.
  Parameters:
    - buffer (System.Memory`1[System.Char]): When this method returns, contains the specified memory block of characters replaced by the characters read from the current source.
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests. The default value is System.Threading.CancellationToken.None.

ReadBlockAsync(Char[], Int32, Int32) -> Int32]
  Summary: Reads a specified maximum number of characters from the current text reader asynchronously and writes the data to a buffer, beginning at the specified index.
  Returns: A task that represents the asynchronous read operation. The value of the TResult parameter contains the total number of bytes read into the buffer. The result value can be less than the number of bytes requested if the number of bytes currently available is less than the requested number, or it can be 0 (zero) if the end of the text has been reached.
  Parameters:
    - buffer (System.Char[]): When this method returns, contains the specified character array with the values between index and (index + count - 1) replaced by the characters read from the current source.
    - index (System.Int32): The position in buffer at which to begin writing.
    - count (System.Int32): The maximum number of characters to read. If the end of the text is reached before the specified number of characters is read into the buffer, the current method returns.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Char[]")) (cl:numberp cancellation-token) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "ReadBlockAsync" buffer cancellation-token count))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Memory`1[[System.Char, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null cancellation-token) (dotnet:is-instance-of cancellation-token "System.Threading.CancellationToken")) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "ReadBlockAsync" buffer cancellation-token))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-TEXT-READER"
                    :class-name <type-str>
                    :method-name "ReadBlockAsync"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:list :cancellation-token cancellation-token) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun read-line (obj!)
  "Summary: Reads a line of characters from the text reader and returns the data as a string.
Returns: The next line from the reader, or if all characters have been read.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "ReadLine"))

(cl:defun read-line-async (obj! cl:&optional (cancellation-token cl:nil supplied-cancellation-token))
  "Master wrapper for System.IO.TextReader.ReadLineAsync overloads. Dispatches at runtime.

ReadLineAsync() -> String]
  Summary: Reads a line of characters asynchronously and returns the data as a string.
  Returns: A task that represents the asynchronous read operation. The value of the TResult parameter contains the next line from the text reader, or is if all of the characters have been read.

ReadLineAsync(CancellationToken) -> String]
  Summary: Reads a line of characters asynchronously and returns the data as a string.
  Returns: A value task that represents the asynchronous read operation. The value of the TResult parameter contains the next line from the text reader, or is if all of the characters have been read.
  Parameters:
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests.
"
  (cl:cond
    ((cl:and supplied-cancellation-token (cl:or (cl:null cancellation-token) (dotnet:is-instance-of cancellation-token "System.Threading.CancellationToken")))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "ReadLineAsync" cancellation-token))
    ((cl:and (cl:not supplied-cancellation-token))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "ReadLineAsync"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-TEXT-READER"
                    :class-name <type-str>
                    :method-name "ReadLineAsync"
                    :supplied-args (cl:append (cl:when supplied-cancellation-token (cl:list :cancellation-token cancellation-token)))))))

(cl:defun read-to-end (obj!)
  "Summary: Reads all characters from the current position to the end of the text reader and returns them as one string.
Returns: A string that contains all characters from the current position to the end of the text reader.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "ReadToEnd"))

(cl:defun read-to-end-async (obj! cl:&optional (cancellation-token cl:nil supplied-cancellation-token))
  "Master wrapper for System.IO.TextReader.ReadToEndAsync overloads. Dispatches at runtime.

ReadToEndAsync() -> String]
  Summary: Reads all characters from the current position to the end of the text reader asynchronously and returns them as one string.
  Returns: A task that represents the asynchronous read operation. The value of the TResult parameter contains a string with the characters from the current position to the end of the text reader.

ReadToEndAsync(CancellationToken) -> String]
  Summary: Reads all characters from the current position to the end of the text reader asynchronously and returns them as one string.
  Returns: A task that represents the asynchronous read operation. The value of the TResult parameter contains a string with the characters from the current position to the end of the text reader.
  Parameters:
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests.
"
  (cl:cond
    ((cl:and supplied-cancellation-token (cl:or (cl:null cancellation-token) (dotnet:is-instance-of cancellation-token "System.Threading.CancellationToken")))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "ReadToEndAsync" cancellation-token))
    ((cl:and (cl:not supplied-cancellation-token))
     (dotnet:invoke (cl:the (dotnet "System.IO.TextReader") obj!) "ReadToEndAsync"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-TEXT-READER"
                    :class-name <type-str>
                    :method-name "ReadToEndAsync"
                    :supplied-args (cl:append (cl:when supplied-cancellation-token (cl:list :cancellation-token cancellation-token)))))))

(cl:defun synchronized (reader)
  "Summary: Creates a thread-safe wrapper around the specified .
Returns: A thread-safe System.IO.TextReader.
Parameters:
  - reader (System.IO.TextReader): The to synchronize.
"
  (dotnet:static <type-str> "Synchronized" (cl:the (dotnet "System.IO.TextReader") reader)))

