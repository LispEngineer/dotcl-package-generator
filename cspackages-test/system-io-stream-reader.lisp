;;; Generated automatically. Do not edit.
;;; Class: System.IO.StreamReader
;;; Generator Version: 34
;;; Creation Date: 2026-07-05T17:20:43Z

(cl:in-package :system-io-stream-reader)

(cl:defconstant <type> (dotnet:resolve-type "System.IO.StreamReader"))
(cl:defconstant <type-str> "System.IO.StreamReader")
(cl:defconstant <creation> "2026-07-05T17:20:43Z")
(cl:defconstant <version> 34)

;; Register C# Type with CLOS
(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (dotnet:static "DotCL.Runtime" "EnsureDotNetTypeClass"
                 (dotnet:resolve-type "System.IO.StreamReader")))

(cl:defun new (stream cl:&optional (detect-encoding-from-byte-order-marks cl:nil supplied-detect-encoding-from-byte-order-marks) (detect-encoding-from-byte-order-marks2 cl:nil supplied-detect-encoding-from-byte-order-marks2) (buffer-size cl:nil supplied-buffer-size))
  "Master wrapper for System.IO.StreamReader constructor overloads. Dispatches at runtime.

new(Stream)
  Summary: Initializes a new instance of the System.IO.StreamReader class for the specified stream.
  Parameters:
    - stream (System.IO.Stream): The stream to be read.

new(String)
  Summary: Initializes a new instance of the System.IO.StreamReader class for the specified file name.
  Parameters:
    - path (System.String): The complete file path to be read.

new(Stream, Boolean)
  Summary: Initializes a new instance of the System.IO.StreamReader class for the specified stream, with the specified byte order mark detection option.
  Parameters:
    - stream (System.IO.Stream): The stream to be read.
    - detect-encoding-from-byte-order-marks (System.Boolean): Indicates whether to look for byte order marks at the beginning of the file.

new(Stream, Encoding)
  Summary: Initializes a new instance of the System.IO.StreamReader class for the specified stream, with the specified character encoding.
  Parameters:
    - stream (System.IO.Stream): The stream to be read.
    - encoding (System.Text.Encoding): The character encoding to use.

new(String, Boolean)
  Summary: Initializes a new instance of the System.IO.StreamReader class for the specified file name, with the specified byte order mark detection option.
  Parameters:
    - path (System.String): The complete file path to be read.
    - detect-encoding-from-byte-order-marks (System.Boolean): Indicates whether to look for byte order marks at the beginning of the file.

new(String, Encoding)
  Summary: Initializes a new instance of the System.IO.StreamReader class for the specified file name, with the specified character encoding.
  Parameters:
    - path (System.String): The complete file path to be read.
    - encoding (System.Text.Encoding): The character encoding to use.

new(String, FileStreamOptions)
  Summary: Initializes a new instance of the System.IO.StreamReader class for the specified file path, using the default encoding, enabling detection of byte order marks at the beginning of the file, and configured with the specified System.IO.FileStreamOptions object.
  Parameters:
    - path (System.String): The complete file path to be read.
    - options (System.IO.FileStreamOptions): An object that specifies the configuration options for the underlying System.IO.FileStream.

new(Stream, Encoding, Boolean)
  Summary: Initializes a new instance of the System.IO.StreamReader class for the specified stream, with the specified character encoding and byte order mark detection option.
  Parameters:
    - stream (System.IO.Stream): The stream to be read.
    - encoding (System.Text.Encoding): The character encoding to use.
    - detect-encoding-from-byte-order-marks (System.Boolean): Indicates whether to look for byte order marks at the beginning of the file.

new(String, Encoding, Boolean)
  Summary: Initializes a new instance of the System.IO.StreamReader class for the specified file name, with the specified character encoding and byte order mark detection option.
  Parameters:
    - path (System.String): The complete file path to be read.
    - encoding (System.Text.Encoding): The character encoding to use.
    - detect-encoding-from-byte-order-marks (System.Boolean): Indicates whether to look for byte order marks at the beginning of the file.

new(Stream, Encoding, Boolean, Int32)
  Summary: Initializes a new instance of the System.IO.StreamReader class for the specified stream, with the specified character encoding, byte order mark detection option, and buffer size.
  Parameters:
    - stream (System.IO.Stream): The stream to be read.
    - encoding (System.Text.Encoding): The character encoding to use.
    - detect-encoding-from-byte-order-marks (System.Boolean): Indicates whether to look for byte order marks at the beginning of the file.
    - buffer-size (System.Int32): The minimum buffer size, in bytes.

new(String, Encoding, Boolean, Int32)
  Summary: Initializes a new instance of the System.IO.StreamReader class for the specified file name, with the specified character encoding, byte order mark detection option, and buffer size.
  Parameters:
    - path (System.String): The complete file path to be read.
    - encoding (System.Text.Encoding): The character encoding to use.
    - detect-encoding-from-byte-order-marks (System.Boolean): Indicates whether to look for byte order marks at the beginning of the file.
    - buffer-size (System.Int32): The minimum buffer size, in bytes.

new(String, Encoding, Boolean, FileStreamOptions)
  Summary: Initializes a new instance of the System.IO.StreamReader class for the specified file path, with the specified character encoding, byte order mark detection option, and configured with the specified System.IO.FileStreamOptions object.
  Parameters:
    - path (System.String): The complete file path to be read.
    - encoding (System.Text.Encoding): The character encoding to use.
    - detect-encoding-from-byte-order-marks (System.Boolean): Indicates whether to look for byte order marks at the beginning of the file.
    - options (System.IO.FileStreamOptions): An object that specifies the configuration options for the underlying System.IO.FileStream.
"
  (cl:cond
    ((cl:and (cl:or (cl:null stream) (dotnet:object-type stream)) supplied-detect-encoding-from-byte-order-marks (cl:or (cl:null detect-encoding-from-byte-order-marks) (dotnet:object-type detect-encoding-from-byte-order-marks)) supplied-detect-encoding-from-byte-order-marks2 (cl:typep detect-encoding-from-byte-order-marks2 'cl:boolean) supplied-buffer-size (cl:numberp buffer-size))
     (dotnet:new <type-str> stream detect-encoding-from-byte-order-marks detect-encoding-from-byte-order-marks2 buffer-size))
    ((cl:and (cl:stringp stream) supplied-detect-encoding-from-byte-order-marks (cl:or (cl:null detect-encoding-from-byte-order-marks) (dotnet:object-type detect-encoding-from-byte-order-marks)) supplied-detect-encoding-from-byte-order-marks2 (cl:typep detect-encoding-from-byte-order-marks2 'cl:boolean) supplied-buffer-size (cl:numberp buffer-size))
     (dotnet:new <type-str> stream detect-encoding-from-byte-order-marks detect-encoding-from-byte-order-marks2 buffer-size))
    ((cl:and (cl:stringp stream) supplied-detect-encoding-from-byte-order-marks (cl:or (cl:null detect-encoding-from-byte-order-marks) (dotnet:object-type detect-encoding-from-byte-order-marks)) supplied-detect-encoding-from-byte-order-marks2 (cl:typep detect-encoding-from-byte-order-marks2 'cl:boolean) supplied-buffer-size (cl:or (cl:null buffer-size) (dotnet:object-type buffer-size)))
     (dotnet:new <type-str> stream detect-encoding-from-byte-order-marks detect-encoding-from-byte-order-marks2 buffer-size))
    ((cl:and (cl:or (cl:null stream) (dotnet:object-type stream)) supplied-detect-encoding-from-byte-order-marks (cl:or (cl:null detect-encoding-from-byte-order-marks) (dotnet:object-type detect-encoding-from-byte-order-marks)) supplied-detect-encoding-from-byte-order-marks2 (cl:typep detect-encoding-from-byte-order-marks2 'cl:boolean) (cl:not supplied-buffer-size))
     (dotnet:new <type-str> stream detect-encoding-from-byte-order-marks detect-encoding-from-byte-order-marks2))
    ((cl:and (cl:stringp stream) supplied-detect-encoding-from-byte-order-marks (cl:or (cl:null detect-encoding-from-byte-order-marks) (dotnet:object-type detect-encoding-from-byte-order-marks)) supplied-detect-encoding-from-byte-order-marks2 (cl:typep detect-encoding-from-byte-order-marks2 'cl:boolean) (cl:not supplied-buffer-size))
     (dotnet:new <type-str> stream detect-encoding-from-byte-order-marks detect-encoding-from-byte-order-marks2))
    ((cl:and (cl:or (cl:null stream) (dotnet:object-type stream)) supplied-detect-encoding-from-byte-order-marks (cl:typep detect-encoding-from-byte-order-marks 'cl:boolean) (cl:not supplied-detect-encoding-from-byte-order-marks2) (cl:not supplied-buffer-size))
     (dotnet:new <type-str> stream detect-encoding-from-byte-order-marks))
    ((cl:and (cl:or (cl:null stream) (dotnet:object-type stream)) supplied-detect-encoding-from-byte-order-marks (cl:or (cl:null detect-encoding-from-byte-order-marks) (dotnet:object-type detect-encoding-from-byte-order-marks)) (cl:not supplied-detect-encoding-from-byte-order-marks2) (cl:not supplied-buffer-size))
     (dotnet:new <type-str> stream detect-encoding-from-byte-order-marks))
    ((cl:and (cl:stringp stream) supplied-detect-encoding-from-byte-order-marks (cl:typep detect-encoding-from-byte-order-marks 'cl:boolean) (cl:not supplied-detect-encoding-from-byte-order-marks2) (cl:not supplied-buffer-size))
     (dotnet:new <type-str> stream detect-encoding-from-byte-order-marks))
    ((cl:and (cl:stringp stream) supplied-detect-encoding-from-byte-order-marks (cl:or (cl:null detect-encoding-from-byte-order-marks) (dotnet:object-type detect-encoding-from-byte-order-marks)) (cl:not supplied-detect-encoding-from-byte-order-marks2) (cl:not supplied-buffer-size))
     (dotnet:new <type-str> stream detect-encoding-from-byte-order-marks))
    ((cl:and (cl:stringp stream) supplied-detect-encoding-from-byte-order-marks (cl:or (cl:null detect-encoding-from-byte-order-marks) (dotnet:object-type detect-encoding-from-byte-order-marks)) (cl:not supplied-detect-encoding-from-byte-order-marks2) (cl:not supplied-buffer-size))
     (dotnet:new <type-str> stream detect-encoding-from-byte-order-marks))
    ((cl:and (cl:or (cl:null stream) (dotnet:object-type stream)) (cl:not supplied-detect-encoding-from-byte-order-marks) (cl:not supplied-detect-encoding-from-byte-order-marks2) (cl:not supplied-buffer-size))
     (dotnet:new <type-str> stream))
    ((cl:and (cl:stringp stream) (cl:not supplied-detect-encoding-from-byte-order-marks) (cl:not supplied-detect-encoding-from-byte-order-marks2) (cl:not supplied-buffer-size))
     (dotnet:new <type-str> stream))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM-READER"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:list :stream stream) (cl:when supplied-detect-encoding-from-byte-order-marks (cl:list :detect-encoding-from-byte-order-marks detect-encoding-from-byte-order-marks)) (cl:when supplied-detect-encoding-from-byte-order-marks2 (cl:list :detect-encoding-from-byte-order-marks2 detect-encoding-from-byte-order-marks2)) (cl:when supplied-buffer-size (cl:list :buffer-size buffer-size)))))))

;; Note: System.IO.StreamReader also has the following constructors with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   new(Stream, Encoding, Boolean, Int32, Boolean)

(cl:define-symbol-macro null (dotnet:static <type-str> "Null"))
(cl:setf (cl:documentation (cl:quote null) (cl:quote cl:variable)) "A System.IO.StreamReader object around an empty stream.")

(cl:defun base-stream (obj!)
  "Returns the underlying stream."
  (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "get_BaseStream"))

(cl:defun current-encoding (obj!)
  "Gets the current character encoding that the current System.IO.StreamReader object is using."
  (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "get_CurrentEncoding"))

(cl:defun end-of-stream (obj!)
  "Gets a value that indicates whether the current stream position is at the end of the stream."
  (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "get_EndOfStream"))

(cl:defun close (obj!)
  "Summary: Closes the System.IO.StreamReader object and the underlying stream, and releases any system resources associated with the reader.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "Close"))

(cl:defun discard-buffered-data (obj!)
  "Summary: Clears the internal buffer.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "DiscardBufferedData"))

(cl:defun dispose (obj! disposing)
  "Summary: Closes the underlying stream, releases the unmanaged resources used by the System.IO.StreamReader, and optionally releases the managed resources.
Parameters:
  - disposing (System.Boolean): to release both managed and unmanaged resources; to release only unmanaged resources.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "Dispose" disposing))

(cl:defun peek (obj!)
  "Summary: Returns the next available character but does not consume it.
Returns: An integer representing the next character to be read, or -1 if there are no characters to be read or if the stream does not support seeking.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "Peek"))

(cl:defun read (obj! cl:&optional (buffer cl:nil supplied-buffer) (index cl:nil supplied-index) (count cl:nil supplied-count))
  "Master wrapper for System.IO.StreamReader.Read overloads. Dispatches at runtime.

Read() -> Int32
  Summary: Reads the next character from the input stream and advances the character position by one character.
  Returns: The next character from the input stream represented as an System.Int32 object, or -1 if no more characters are available.

Read(Char]) -> Int32
  Summary: Reads the characters from the current stream into a span.
  Returns: The number of characters that have been read, or 0 if at the end of the stream and no data was read. The number will be less than or equal to the buffer length, depending on whether the data is available within the stream.
  Parameters:
    - buffer (System.Span`1[System.Char]): When this method returns, contains the specified span of characters replaced by the characters read from the current source.

Read(Char[], Int32, Int32) -> Int32
  Summary: Reads a specified maximum of characters from the current stream into a buffer, beginning at the specified index.
  Returns: The number of characters that have been read, or 0 if at the end of the stream and no data was read. The number will be less than or equal to the count parameter, depending on whether the data is available within the stream.
  Parameters:
    - buffer (System.Char[]): When this method returns, contains the specified character array with the values between index and (index + count - 1) replaced by the characters read from the current source.
    - index (System.Int32): The index of buffer at which to begin writing.
    - count (System.Int32): The maximum number of characters to read.
"
  (cl:cond
    ((cl:and supplied-buffer (cl:or (cl:null buffer) (dotnet:object-type buffer)) supplied-index (cl:numberp index) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "Read" buffer index count))
    ((cl:and supplied-buffer (cl:or (cl:null buffer) (dotnet:object-type buffer)) (cl:not supplied-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "Read" buffer))
    ((cl:and (cl:not supplied-buffer) (cl:not supplied-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "Read"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM-READER"
                    :class-name <type-str>
                    :method-name "Read"
                    :supplied-args (cl:append (cl:when supplied-buffer (cl:list :buffer buffer)) (cl:when supplied-index (cl:list :index index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun read-async (obj! buffer cl:&optional (cancellation-token cl:nil supplied-cancellation-token) (count cl:nil supplied-count))
  "Master wrapper for System.IO.StreamReader.ReadAsync overloads. Dispatches at runtime.

ReadAsync(Char], CancellationToken) -> Int32]
  Summary: Asynchronously reads the characters from the current stream into a memory block.
  Returns: A value task that represents the asynchronous read operation. The value of the type parameter of the value task contains the number of characters that have been read, or 0 if at the end of the stream and no data was read. The number will be less than or equal to the buffer length, depending on whether the data is available within the stream.
  Parameters:
    - buffer (System.Memory`1[System.Char]): When this method returns, contains the specified memory block of characters replaced by the characters read from the current source.
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests. The default value is System.Threading.CancellationToken.None.

ReadAsync(Char[], Int32, Int32) -> Int32]
  Summary: Reads a specified maximum number of characters from the current stream asynchronously and writes the data to a buffer, beginning at the specified index.
  Returns: A task that represents the asynchronous read operation. The value of the TResult parameter contains the total number of characters read into the buffer. The result value can be less than the number of characters requested if the number of characters currently available is less than the requested number, or it can be 0 (zero) if the end of the stream has been reached.
  Parameters:
    - buffer (System.Char[]): When this method returns, contains the specified character array with the values between index and (index + count - 1) replaced by the characters read from the current source.
    - index (System.Int32): The position in buffer at which to begin writing.
    - count (System.Int32): The maximum number of characters to read. If the end of the stream is reached before the specified number of characters is written into the buffer, the current method returns.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:object-type buffer)) supplied-cancellation-token (cl:numberp cancellation-token) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "ReadAsync" buffer cancellation-token count))
    ((cl:and (cl:or (cl:null buffer) (dotnet:object-type buffer)) supplied-cancellation-token (cl:or (cl:null cancellation-token) (dotnet:object-type cancellation-token)) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "ReadAsync" buffer cancellation-token))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM-READER"
                    :class-name <type-str>
                    :method-name "ReadAsync"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:when supplied-cancellation-token (cl:list :cancellation-token cancellation-token)) (cl:when supplied-count (cl:list :count count)))))))

;; Note: System.IO.StreamReader.ReadAsync also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ReadAsync(Char], CancellationToken) -> Int32]

(cl:defun read-block (obj! buffer cl:&optional (index cl:nil supplied-index) (count cl:nil supplied-count))
  "Master wrapper for System.IO.StreamReader.ReadBlock overloads. Dispatches at runtime.

ReadBlock(Char]) -> Int32
  Summary: Reads the characters from the current stream and writes the data to a buffer.
  Returns: The number of characters that have been read. The number will be less than or equal to the buffer length, depending on whether all input characters have been read.
  Parameters:
    - buffer (System.Span`1[System.Char]): When this method returns, contains the specified span of characters replaced by the characters read from the current source.

ReadBlock(Char[], Int32, Int32) -> Int32
  Summary: Reads a specified maximum number of characters from the current stream and writes the data to a buffer, beginning at the specified index.
  Returns: The number of characters that have been read. The number will be less than or equal to count, depending on whether all input characters have been read.
  Parameters:
    - buffer (System.Char[]): When this method returns, contains the specified character array with the values between index and (index + count - 1) replaced by the characters read from the current source.
    - index (System.Int32): The position in buffer at which to begin writing.
    - count (System.Int32): The maximum number of characters to read.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:object-type buffer)) supplied-index (cl:numberp index) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "ReadBlock" buffer index count))
    ((cl:and (cl:or (cl:null buffer) (dotnet:object-type buffer)) (cl:not supplied-index) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "ReadBlock" buffer))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM-READER"
                    :class-name <type-str>
                    :method-name "ReadBlock"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:when supplied-index (cl:list :index index)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun read-block-async (obj! buffer cl:&optional (cancellation-token cl:nil supplied-cancellation-token) (count cl:nil supplied-count))
  "Master wrapper for System.IO.StreamReader.ReadBlockAsync overloads. Dispatches at runtime.

ReadBlockAsync(Char], CancellationToken) -> Int32]
  Summary: Asynchronously reads the characters from the current stream and writes the data to a buffer.
  Returns: A value task that represents the asynchronous read operation. The value of the type parameter of the value task contains the total number of characters read into the buffer. The result value can be less than the number of characters requested if the number of characters currently available is less than the requested number, or it can be 0 (zero) if the end of the stream has been reached.
  Parameters:
    - buffer (System.Memory`1[System.Char]): When this method returns, contains the specified memory block of characters replaced by the characters read from the current source.
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests. The default value is System.Threading.CancellationToken.None.

ReadBlockAsync(Char[], Int32, Int32) -> Int32]
  Summary: Reads a specified maximum number of characters from the current stream asynchronously and writes the data to a buffer, beginning at the specified index.
  Returns: A task that represents the asynchronous read operation. The value of the TResult parameter contains the total number of characters read into the buffer. The result value can be less than the number of characters requested if the number of characters currently available is less than the requested number, or it can be 0 (zero) if the end of the stream has been reached.
  Parameters:
    - buffer (System.Char[]): When this method returns, contains the specified character array with the values between index and (index + count - 1) replaced by the characters read from the current source.
    - index (System.Int32): The position in buffer at which to begin writing.
    - count (System.Int32): The maximum number of characters to read. If the end of the stream is reached before the specified number of characters is written into the buffer, the method returns.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:object-type buffer)) supplied-cancellation-token (cl:numberp cancellation-token) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "ReadBlockAsync" buffer cancellation-token count))
    ((cl:and (cl:or (cl:null buffer) (dotnet:object-type buffer)) supplied-cancellation-token (cl:or (cl:null cancellation-token) (dotnet:object-type cancellation-token)) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "ReadBlockAsync" buffer cancellation-token))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM-READER"
                    :class-name <type-str>
                    :method-name "ReadBlockAsync"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:when supplied-cancellation-token (cl:list :cancellation-token cancellation-token)) (cl:when supplied-count (cl:list :count count)))))))

;; Note: System.IO.StreamReader.ReadBlockAsync also has the following overloads with special
;; parameter types (ref, out, params, or defaults) that are not
;; yet supported:
;;   ReadBlockAsync(Char], CancellationToken) -> Int32]

(cl:defun read-line (obj!)
  "Summary: Reads a line of characters from the current stream and returns the data as a string.
Returns: The next line from the input stream, or if the end of the input stream is reached.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "ReadLine"))

(cl:defun read-line-async (obj! cl:&optional (cancellation-token cl:nil supplied-cancellation-token))
  "Master wrapper for System.IO.StreamReader.ReadLineAsync overloads. Dispatches at runtime.

ReadLineAsync() -> String]
  Summary: Reads a line of characters asynchronously from the current stream and returns the data as a string.
  Returns: A task that represents the asynchronous read operation. The value of the TResult parameter contains the next line from the stream, or is if all the characters have been read.

ReadLineAsync(CancellationToken) -> String]
  Summary: Reads a line of characters asynchronously from the current stream and returns the data as a string.
  Returns: A value task that represents the asynchronous read operation. The value of the TResult parameter contains the next line from the stream, or is if all of the characters have been read.
  Parameters:
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests.
"
  (cl:cond
    ((cl:and supplied-cancellation-token (cl:or (cl:null cancellation-token) (dotnet:object-type cancellation-token)))
     (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "ReadLineAsync" cancellation-token))
    ((cl:and (cl:not supplied-cancellation-token))
     (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "ReadLineAsync"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM-READER"
                    :class-name <type-str>
                    :method-name "ReadLineAsync"
                    :supplied-args (cl:append (cl:when supplied-cancellation-token (cl:list :cancellation-token cancellation-token)))))))

(cl:defun read-to-end (obj!)
  "Summary: Reads all characters from the current position to the end of the stream.
Returns: The rest of the stream as a string, from the current position to the end. If the current position is at the end of the stream, returns an empty string (\"\").
"
  (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "ReadToEnd"))

(cl:defun read-to-end-async (obj! cl:&optional (cancellation-token cl:nil supplied-cancellation-token))
  "Master wrapper for System.IO.StreamReader.ReadToEndAsync overloads. Dispatches at runtime.

ReadToEndAsync() -> String]
  Summary: Reads all characters from the current position to the end of the stream asynchronously and returns them as one string.
  Returns: A task that represents the asynchronous read operation. The value of the TResult parameter contains a string with the characters from the current position to the end of the stream.

ReadToEndAsync(CancellationToken) -> String]
  Summary: Reads all characters from the current position to the end of the stream asynchronously and returns them as one string.
  Returns: A task that represents the asynchronous read operation. The value of the TResult parameter contains a string with the characters from the current position to the end of the stream.
  Parameters:
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests.
"
  (cl:cond
    ((cl:and supplied-cancellation-token (cl:or (cl:null cancellation-token) (dotnet:object-type cancellation-token)))
     (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "ReadToEndAsync" cancellation-token))
    ((cl:and (cl:not supplied-cancellation-token))
     (dotnet:invoke (cl:the (dotnet "System.IO.StreamReader") obj!) "ReadToEndAsync"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM-READER"
                    :class-name <type-str>
                    :method-name "ReadToEndAsync"
                    :supplied-args (cl:append (cl:when supplied-cancellation-token (cl:list :cancellation-token cancellation-token)))))))

