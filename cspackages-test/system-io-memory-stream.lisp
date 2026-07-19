;;; Generated automatically. Do not edit.
;;; Class: System.IO.MemoryStream
;;; Generator Version: 51
;;; Creation Date: 2026-07-19T15:11:53Z

(cl:in-package :system-io-memory-stream)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.IO.MemoryStream"))
(cl:defconstant <type-str> "System.IO.MemoryStream")
(cl:defconstant <creation> "2026-07-19T15:11:53Z")
(cl:defconstant <version> 51)

(cl:defun new (cl:&optional (capacity cl:nil supplied-capacity) (writable cl:nil supplied-writable) (count cl:nil supplied-count) (writable2 cl:nil supplied-writable2) (publicly-visible cl:nil supplied-publicly-visible))
  "Master wrapper for System.IO.MemoryStream constructor overloads. Dispatches at runtime.

new()
  Summary: Initializes a new instance of the System.IO.MemoryStream class with an expandable capacity initialized to zero.

new(Int32)
  Summary: Initializes a new instance of the System.IO.MemoryStream class with an expandable capacity initialized as specified.
  Parameters:
    - capacity (System.Int32): The initial size of the internal array in bytes.

new(Byte[])
  Summary: Initializes a new non-resizable instance of the System.IO.MemoryStream class based on the specified byte array.
  Parameters:
    - buffer (System.Byte[]): The array of unsigned bytes from which to create the current stream.

new(Byte[], Boolean)
  Summary: Initializes a new non-resizable instance of the System.IO.MemoryStream class based on the specified byte array with the System.IO.MemoryStream.CanWrite property set as specified.
  Parameters:
    - buffer (System.Byte[]): The array of unsigned bytes from which to create this stream.
    - writable (System.Boolean): The setting of the System.IO.MemoryStream.CanWrite property, which determines whether the stream supports writing.

new(Byte[], Int32, Int32)
  Summary: Initializes a new non-resizable instance of the System.IO.MemoryStream class based on the specified region (index) of a byte array.
  Parameters:
    - buffer (System.Byte[]): The array of unsigned bytes from which to create this stream.
    - index (System.Int32): The index into buffer at which the stream begins.
    - count (System.Int32): The length of the stream in bytes.

new(Byte[], Int32, Int32, Boolean)
  Summary: Initializes a new non-resizable instance of the System.IO.MemoryStream class based on the specified region of a byte array, with the System.IO.MemoryStream.CanWrite property set as specified.
  Parameters:
    - buffer (System.Byte[]): The array of unsigned bytes from which to create this stream.
    - index (System.Int32): The index in buffer at which the stream begins.
    - count (System.Int32): The length of the stream in bytes.
    - writable (System.Boolean): The setting of the System.IO.MemoryStream.CanWrite property, which determines whether the stream supports writing.

new(Byte[], Int32, Int32, Boolean, Boolean)
  Summary: Initializes a new instance of the System.IO.MemoryStream class based on the specified region of a byte array, with the System.IO.MemoryStream.CanWrite property set as specified, and the ability to call System.IO.MemoryStream.GetBuffer set as specified.
  Parameters:
    - buffer (System.Byte[]): The array of unsigned bytes from which to create this stream.
    - index (System.Int32): The index into buffer at which the stream begins.
    - count (System.Int32): The length of the stream in bytes.
    - writable (System.Boolean): The setting of the System.IO.MemoryStream.CanWrite property, which determines whether the stream supports writing.
    - publicly-visible (System.Boolean): to enable System.IO.MemoryStream.GetBuffer, which returns the unsigned byte array from which the stream was created; otherwise, .
"
  (cl:cond
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:is-instance-of capacity "System.Byte[]")) supplied-writable (cl:numberp writable) supplied-count (cl:numberp count) supplied-writable2 (cl:typep writable2 'cl:boolean) supplied-publicly-visible (cl:typep publicly-visible 'cl:boolean))
     (dotnet:new <type-str> capacity writable count writable2 publicly-visible))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:is-instance-of capacity "System.Byte[]")) supplied-writable (cl:numberp writable) supplied-count (cl:numberp count) supplied-writable2 (cl:typep writable2 'cl:boolean) (cl:not supplied-publicly-visible))
     (dotnet:new <type-str> capacity writable count writable2))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:is-instance-of capacity "System.Byte[]")) supplied-writable (cl:numberp writable) supplied-count (cl:numberp count) (cl:not supplied-writable2) (cl:not supplied-publicly-visible))
     (dotnet:new <type-str> capacity writable count))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:is-instance-of capacity "System.Byte[]")) supplied-writable (cl:typep writable 'cl:boolean) (cl:not supplied-count) (cl:not supplied-writable2) (cl:not supplied-publicly-visible))
     (dotnet:new <type-str> capacity writable))
    ((cl:and supplied-capacity (cl:numberp capacity) (cl:not supplied-writable) (cl:not supplied-count) (cl:not supplied-writable2) (cl:not supplied-publicly-visible))
     (dotnet:new <type-str> capacity))
    ((cl:and supplied-capacity (cl:or (cl:null capacity) (dotnet:is-instance-of capacity "System.Byte[]")) (cl:not supplied-writable) (cl:not supplied-count) (cl:not supplied-writable2) (cl:not supplied-publicly-visible))
     (dotnet:new <type-str> capacity))
    ((cl:and (cl:not supplied-capacity) (cl:not supplied-writable) (cl:not supplied-count) (cl:not supplied-writable2) (cl:not supplied-publicly-visible))
     (dotnet:new <type-str>))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-MEMORY-STREAM"
                    :class-name <type-str>
                    :method-name "new"
                    :supplied-args (cl:append (cl:when supplied-capacity (cl:list :capacity capacity)) (cl:when supplied-writable (cl:list :writable writable)) (cl:when supplied-count (cl:list :count count)) (cl:when supplied-writable2 (cl:list :writable2 writable2)) (cl:when supplied-publicly-visible (cl:list :publicly-visible publicly-visible)))))))

(cl:defun can-read (obj!)
  "Gets a value indicating whether the current stream supports reading."
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "get_CanRead"))

(cl:defun can-seek (obj!)
  "Gets a value indicating whether the current stream supports seeking."
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "get_CanSeek"))

(cl:defun can-write (obj!)
  "Gets a value indicating whether the current stream supports writing."
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "get_CanWrite"))

(cl:defun capacity (obj!)
  "Gets or sets the number of bytes allocated for this stream."
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "get_Capacity"))

(cl:defun (cl:setf capacity) (new-value obj!)
  "Gets or sets the number of bytes allocated for this stream."
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "set_Capacity" new-value))

(cl:defun length (obj!)
  "Gets the length of the stream in bytes."
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "get_Length"))

(cl:defun position (obj!)
  "Gets or sets the current position within the stream."
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "get_Position"))

(cl:defun (cl:setf position) (new-value obj!)
  "Gets or sets the current position within the stream."
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "set_Position" new-value))

(cl:defun copy-to (obj! destination buffer-size)
  "Summary: Reads the bytes from the current memory stream and writes them to another stream, using a specified buffer size.
Parameters:
  - destination (System.IO.Stream): The stream to which the contents of the current memory stream will be copied.
  - buffer-size (System.Int32): The size of the buffer. This value must be greater than zero. The default size is 81920.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "CopyTo" destination buffer-size))

(cl:defun copy-to-async (obj! destination buffer-size cancellation-token)
  "Summary: Asynchronously reads all the bytes from the current stream and writes them to another stream, using a specified buffer size and cancellation token.
Returns: A task that represents the asynchronous copy operation.
Parameters:
  - destination (System.IO.Stream): The stream to which the contents of the current stream will be copied.
  - buffer-size (System.Int32): The size, in bytes, of the buffer. This value must be greater than zero.
  - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "CopyToAsync" destination buffer-size cancellation-token))

(cl:defun dispose (obj! disposing)
  "Summary: Releases the unmanaged resources used by the System.IO.MemoryStream class and optionally releases the managed resources.
Parameters:
  - disposing (System.Boolean): to release both managed and unmanaged resources; to release only unmanaged resources.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "Dispose" disposing))

(cl:defun flush (obj!)
  "Summary: Overrides the System.IO.Stream.Flush method so that no action is performed.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "Flush"))

(cl:defun flush-async (obj! cancellation-token)
  "Summary: Asynchronously clears all buffers for this stream, and monitors cancellation requests.
Returns: A task that represents the asynchronous flush operation.
Parameters:
  - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "FlushAsync" cancellation-token))

(cl:defun get-buffer (obj!)
  "Summary: Returns the array of unsigned bytes from which this stream was created.
Returns: The byte array from which this stream was created, or the underlying array if a byte array was not provided to the System.IO.MemoryStream constructor during construction of the current instance.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "GetBuffer"))

(cl:defun read (obj! buffer cl:&optional (offset cl:nil supplied-offset) (count cl:nil supplied-count))
  "Master wrapper for System.IO.MemoryStream.Read overloads. Dispatches at runtime.

Read(Byte]) -> Int32
  Summary: Reads a sequence of bytes from the current memory stream and advances the position within the memory stream by the number of bytes read.
  Returns: The total number of bytes read into the buffer. This can be less than the number of bytes allocated in the buffer if that many bytes are not currently available, or zero (0) if the end of the memory stream has been reached.
  Parameters:
    - buffer (System.Span`1[System.Byte]): 

Read(Byte[], Int32, Int32) -> Int32
  Summary: Reads a block of bytes from the current stream and writes the data to a buffer.
  Returns: The total number of bytes written into the buffer. This can be less than the number of bytes requested if that number of bytes are not currently available, or zero if the end of the stream is reached before any bytes are read.
  Parameters:
    - buffer (System.Byte[]): When this method returns, contains the specified byte array with the values between offset and (offset + count - 1) replaced by the characters read from the current stream.
    - offset (System.Int32): The zero-based byte offset in buffer at which to begin storing data from the current stream.
    - count (System.Int32): The maximum number of bytes to read.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Byte[]")) supplied-offset (cl:numberp offset) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "Read" buffer offset count))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Span`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-offset) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "Read" buffer))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-MEMORY-STREAM"
                    :class-name <type-str>
                    :method-name "Read"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:when supplied-offset (cl:list :offset offset)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun read-async (obj! buffer cancellation-token cl:&optional (count cl:nil supplied-count) (cancellation-token2 cl:nil supplied-cancellation-token2))
  "Master wrapper for System.IO.MemoryStream.ReadAsync overloads. Dispatches at runtime.

ReadAsync(Byte], CancellationToken = default(System.Threading.CancellationToken) [C# default of type System.Threading.CancellationToken -- not representable in Lisp, must be supplied]) -> Int32]
  Summary: Asynchronously reads a sequence of bytes from the current memory stream, writes the sequence into destination, advances the position within the memory stream by the number of bytes read, and monitors cancellation requests.
  Returns: A task that represents the asynchronous read operation. The value of its System.Threading.Tasks.ValueTask`1.Result property contains the total number of bytes read into the destination. The result value can be less than the number of bytes allocated in destination if that many bytes are not currently available, or it can be 0 (zero) if the end of the memory stream has been reached.
  Parameters:
    - buffer (System.Memory`1[System.Byte]): 
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests. The default value is System.Threading.CancellationToken.None.

ReadAsync(Byte[], Int32, Int32, CancellationToken) -> Int32]
  Summary: Asynchronously reads a sequence of bytes from the current stream, advances the position within the stream by the number of bytes read, and monitors cancellation requests.
  Returns: A task that represents the asynchronous read operation. The value of the TResult parameter contains the total number of bytes read into the buffer. The result value can be less than the number of bytes requested if the number of bytes currently available is less than the requested number, or it can be 0 (zero) if the end of the stream has been reached.
  Parameters:
    - buffer (System.Byte[]): The buffer to write the data into.
    - offset (System.Int32): The byte offset in buffer at which to begin writing data from the stream.
    - count (System.Int32): The maximum number of bytes to read.
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests. The default value is System.Threading.CancellationToken.None.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Byte[]")) (cl:numberp cancellation-token) supplied-count (cl:numberp count) supplied-cancellation-token2 (cl:or (cl:null cancellation-token2) (dotnet:is-instance-of cancellation-token2 "System.Threading.CancellationToken")))
     (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "ReadAsync" buffer cancellation-token count cancellation-token2))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Memory`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null cancellation-token) (dotnet:is-instance-of cancellation-token "System.Threading.CancellationToken")) (cl:not supplied-count) (cl:not supplied-cancellation-token2))
     (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "ReadAsync" buffer cancellation-token))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-MEMORY-STREAM"
                    :class-name <type-str>
                    :method-name "ReadAsync"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:list :cancellation-token cancellation-token) (cl:when supplied-count (cl:list :count count)) (cl:when supplied-cancellation-token2 (cl:list :cancellation-token2 cancellation-token2)))))))

(cl:defun read-byte (obj!)
  "Summary: Reads a byte from the current stream.
Returns: The byte cast to a System.Int32, or -1 if the end of the stream has been reached.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "ReadByte"))

(cl:defun seek (obj! offset loc)
  "Summary: Sets the position within the current stream to the specified value.
Returns: The new position within the stream, calculated by combining the initial reference point and the offset.
Parameters:
  - offset (System.Int64): The new position within the stream. This is relative to the loc parameter, and can be positive or negative.
  - loc (System.IO.SeekOrigin): A value of type System.IO.SeekOrigin, which acts as the seek reference point.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "Seek" offset loc))

(cl:defun set-length (obj! value)
  "Summary: Sets the length of the current stream to the specified value.
Parameters:
  - value (System.Int64): The value at which to set the length.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "SetLength" value))

(cl:defun to-array (obj!)
  "Summary: Writes the stream contents to a byte array, regardless of the System.IO.MemoryStream.Position property.
Returns: A new byte array.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "ToArray"))

(cl:defun write (obj! buffer cl:&optional (offset cl:nil supplied-offset) (count cl:nil supplied-count))
  "Master wrapper for System.IO.MemoryStream.Write overloads. Dispatches at runtime.

Write(Byte]) -> Void
  Summary: Writes the sequence of bytes contained in source into the current memory stream and advances the current position within this memory stream by the number of bytes written.
  Parameters:
    - buffer (System.ReadOnlySpan`1[System.Byte]): 

Write(Byte[], Int32, Int32) -> Void
  Summary: Writes a block of bytes to the current stream using data read from a buffer.
  Parameters:
    - buffer (System.Byte[]): The buffer to write data from.
    - offset (System.Int32): The zero-based byte offset in buffer at which to begin copying bytes to the current stream.
    - count (System.Int32): The maximum number of bytes to write.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Byte[]")) supplied-offset (cl:numberp offset) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "Write" buffer offset count))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.ReadOnlySpan`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-offset) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "Write" buffer))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-MEMORY-STREAM"
                    :class-name <type-str>
                    :method-name "Write"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:when supplied-offset (cl:list :offset offset)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun write-async (obj! buffer cancellation-token cl:&optional (count cl:nil supplied-count) (cancellation-token2 cl:nil supplied-cancellation-token2))
  "Master wrapper for System.IO.MemoryStream.WriteAsync overloads. Dispatches at runtime.

WriteAsync(Byte], CancellationToken = default(System.Threading.CancellationToken) [C# default of type System.Threading.CancellationToken -- not representable in Lisp, must be supplied]) -> ValueTask
  Summary: Asynchronously writes the sequence of bytes contained in source into the current memory stream, advances the current position within this memory stream by the number of bytes written, and monitors cancellation requests.
  Returns: A task that represents the asynchronous write operation.
  Parameters:
    - buffer (System.ReadOnlyMemory`1[System.Byte]): 
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests. The default value is System.Threading.CancellationToken.None.

WriteAsync(Byte[], Int32, Int32, CancellationToken) -> Task
  Summary: Asynchronously writes a sequence of bytes to the current stream, advances the current position within this stream by the number of bytes written, and monitors cancellation requests.
  Returns: A task that represents the asynchronous write operation.
  Parameters:
    - buffer (System.Byte[]): The buffer to write data from.
    - offset (System.Int32): The zero-based byte offset in buffer from which to begin copying bytes to the stream.
    - count (System.Int32): The maximum number of bytes to write.
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests. The default value is System.Threading.CancellationToken.None.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Byte[]")) (cl:numberp cancellation-token) supplied-count (cl:numberp count) supplied-cancellation-token2 (cl:or (cl:null cancellation-token2) (dotnet:is-instance-of cancellation-token2 "System.Threading.CancellationToken")))
     (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "WriteAsync" buffer cancellation-token count cancellation-token2))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.ReadOnlyMemory`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null cancellation-token) (dotnet:is-instance-of cancellation-token "System.Threading.CancellationToken")) (cl:not supplied-count) (cl:not supplied-cancellation-token2))
     (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "WriteAsync" buffer cancellation-token))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-MEMORY-STREAM"
                    :class-name <type-str>
                    :method-name "WriteAsync"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:list :cancellation-token cancellation-token) (cl:when supplied-count (cl:list :count count)) (cl:when supplied-cancellation-token2 (cl:list :cancellation-token2 cancellation-token2)))))))

(cl:defun write-byte (obj! value)
  "Summary: Writes a byte to the current stream at the current position.
Parameters:
  - value (System.Byte): The byte to write.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "WriteByte" value))

(cl:defun write-to (obj! stream)
  "Summary: Writes the entire contents of this memory stream to another stream.
Parameters:
  - stream (System.IO.Stream): The stream to write this memory stream to.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.MemoryStream") obj!) "WriteTo" stream))

(cl:defun try-get-buffer (obj!)
  "Returns (cl:values <primary-return> buffer) -- TryGetBuffer(out 0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]]&) -> Boolean
Summary: Returns the array of unsigned bytes from which this stream was created. The return value indicates whether the conversion succeeded.
Returns: if the buffer is exposable; otherwise, .
"
  (dotnet:call-out obj! "TryGetBuffer"))

