;;; Generated automatically. Do not edit.
;;; Class: System.IO.Stream
;;; Generator Version: 51
;;; Creation Date: 2026-07-19T15:11:53Z

(cl:in-package :system-io-stream)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.IO.Stream"))
(cl:defconstant <type-str> "System.IO.Stream")
(cl:defconstant <creation> "2026-07-19T15:11:53Z")
(cl:defconstant <version> 51)

(cl:defun new ()
  "Summary: Initializes a new instance of the System.IO.Stream class.
"
  (dotnet:new <type-str>))

(cl:define-symbol-macro null (dotnet:static <type-str> "Null"))
(cl:setf (cl:documentation (cl:quote null) (cl:quote cl:variable)) "A with no backing store.")

(cl:defun can-read (obj!)
  "When overridden in a derived class, gets a value indicating whether the current stream supports reading."
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "get_CanRead"))

(cl:defun can-seek (obj!)
  "When overridden in a derived class, gets a value indicating whether the current stream supports seeking."
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "get_CanSeek"))

(cl:defun can-timeout (obj!)
  "Gets a value that determines whether the current stream can time out."
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "get_CanTimeout"))

(cl:defun can-write (obj!)
  "When overridden in a derived class, gets a value indicating whether the current stream supports writing."
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "get_CanWrite"))

(cl:defun length (obj!)
  "When overridden in a derived class, gets the length in bytes of the stream."
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "get_Length"))

(cl:defun position (obj!)
  "When overridden in a derived class, gets or sets the position within the current stream."
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "get_Position"))

(cl:defun (cl:setf position) (new-value obj!)
  "When overridden in a derived class, gets or sets the position within the current stream."
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "set_Position" new-value))

(cl:defun read-timeout (obj!)
  "Gets or sets a value, in milliseconds, that determines how long the stream will attempt to read before timing out."
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "get_ReadTimeout"))

(cl:defun (cl:setf read-timeout) (new-value obj!)
  "Gets or sets a value, in milliseconds, that determines how long the stream will attempt to read before timing out."
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "set_ReadTimeout" new-value))

(cl:defun write-timeout (obj!)
  "Gets or sets a value, in milliseconds, that determines how long the stream will attempt to write before timing out."
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "get_WriteTimeout"))

(cl:defun (cl:setf write-timeout) (new-value obj!)
  "Gets or sets a value, in milliseconds, that determines how long the stream will attempt to write before timing out."
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "set_WriteTimeout" new-value))

(cl:defun begin-read (obj! buffer offset count callback state)
  "Summary: Begins an asynchronous read operation. (Consider using System.IO.Stream.ReadAsync(System.Byte[],System.Int32,System.Int32) instead.)
Returns: An System.IAsyncResult that represents the asynchronous read, which could still be pending.
Parameters:
  - buffer (System.Byte[]): The buffer to read the data into.
  - offset (System.Int32): The byte offset in buffer at which to begin writing data read from the stream.
  - count (System.Int32): The maximum number of bytes to read.
  - callback (System.AsyncCallback): An optional asynchronous callback, to be called when the read is complete.
  - state (System.Object): A user-provided object that distinguishes this particular asynchronous read request from other requests.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "BeginRead" buffer offset count callback state))

(cl:defun begin-write (obj! buffer offset count callback state)
  "Summary: Begins an asynchronous write operation. (Consider using System.IO.Stream.WriteAsync(System.Byte[],System.Int32,System.Int32) instead.)
Returns: An that represents the asynchronous write, which could still be pending.
Parameters:
  - buffer (System.Byte[]): The buffer to write data from.
  - offset (System.Int32): The byte offset in buffer from which to begin writing.
  - count (System.Int32): The maximum number of bytes to write.
  - callback (System.AsyncCallback): An optional asynchronous callback, to be called when the write is complete.
  - state (System.Object): A user-provided object that distinguishes this particular asynchronous write request from other requests.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "BeginWrite" buffer offset count callback state))

(cl:defun close (obj!)
  "Summary: Closes the current stream and releases any resources (such as sockets and file handles) associated with the current stream. Instead of calling this method, ensure that the stream is properly disposed.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "Close"))

(cl:defun copy-to (obj! destination cl:&optional (buffer-size cl:nil supplied-buffer-size))
  "Master wrapper for System.IO.Stream.CopyTo overloads. Dispatches at runtime.

CopyTo(Stream) -> Void
  Summary: Reads the bytes from the current stream and writes them to another stream. Both streams positions are advanced by the number of bytes copied.
  Parameters:
    - destination (System.IO.Stream): The stream to which the contents of the current stream will be copied.

CopyTo(Stream, Int32) -> Void
  Summary: Reads the bytes from the current stream and writes them to another stream, using a specified buffer size. Both streams positions are advanced by the number of bytes copied.
  Parameters:
    - destination (System.IO.Stream): The stream to which the contents of the current stream will be copied.
    - buffer-size (System.Int32): The size of the buffer. This value must be greater than zero. The default size is 81920.
"
  (cl:cond
    ((cl:and (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.IO.Stream")) supplied-buffer-size (cl:numberp buffer-size))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "CopyTo" destination buffer-size))
    ((cl:and (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.IO.Stream")) (cl:not supplied-buffer-size))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "CopyTo" destination))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM"
                    :class-name <type-str>
                    :method-name "CopyTo"
                    :supplied-args (cl:append (cl:list :destination destination) (cl:when supplied-buffer-size (cl:list :buffer-size buffer-size)))))))

(cl:defun copy-to-async (obj! destination cl:&optional (buffer-size cl:nil supplied-buffer-size) (cancellation-token cl:nil supplied-cancellation-token))
  "Master wrapper for System.IO.Stream.CopyToAsync overloads. Dispatches at runtime.

CopyToAsync(Stream) -> Task
  Summary: Asynchronously reads the bytes from the current stream and writes them to another stream. Both streams positions are advanced by the number of bytes copied.
  Returns: A task that represents the asynchronous copy operation.
  Parameters:
    - destination (System.IO.Stream): The stream to which the contents of the current stream will be copied.

CopyToAsync(Stream, Int32) -> Task
  Summary: Asynchronously reads the bytes from the current stream and writes them to another stream, using a specified buffer size. Both streams positions are advanced by the number of bytes copied.
  Returns: A task that represents the asynchronous copy operation.
  Parameters:
    - destination (System.IO.Stream): The stream to which the contents of the current stream will be copied.
    - buffer-size (System.Int32): The size, in bytes, of the buffer. This value must be greater than zero. The default size is 81920.

CopyToAsync(Stream, CancellationToken) -> Task
  Summary: Asynchronously reads the bytes from the current stream and writes them to another stream, using a specified cancellation token. Both streams positions are advanced by the number of bytes copied.
  Returns: A task that represents the asynchronous copy operation.
  Parameters:
    - destination (System.IO.Stream): The stream to which the contents of the current stream will be copied.
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests. The default value is System.Threading.CancellationToken.None.

CopyToAsync(Stream, Int32, CancellationToken) -> Task
  Summary: Asynchronously reads the bytes from the current stream and writes them to another stream, using a specified buffer size and cancellation token. Both streams positions are advanced by the number of bytes copied.
  Returns: A task that represents the asynchronous copy operation.
  Parameters:
    - destination (System.IO.Stream): The stream to which the contents of the current stream will be copied.
    - buffer-size (System.Int32): The size, in bytes, of the buffer. This value must be greater than zero. The default size is 81920.
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests. The default value is System.Threading.CancellationToken.None.
"
  (cl:cond
    ((cl:and (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.IO.Stream")) supplied-buffer-size (cl:numberp buffer-size) supplied-cancellation-token (cl:or (cl:null cancellation-token) (dotnet:is-instance-of cancellation-token "System.Threading.CancellationToken")))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "CopyToAsync" destination buffer-size cancellation-token))
    ((cl:and (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.IO.Stream")) supplied-buffer-size (cl:numberp buffer-size) (cl:not supplied-cancellation-token))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "CopyToAsync" destination buffer-size))
    ((cl:and (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.IO.Stream")) supplied-buffer-size (cl:or (cl:null buffer-size) (dotnet:is-instance-of buffer-size "System.Threading.CancellationToken")) (cl:not supplied-cancellation-token))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "CopyToAsync" destination buffer-size))
    ((cl:and (cl:or (cl:null destination) (dotnet:is-instance-of destination "System.IO.Stream")) (cl:not supplied-buffer-size) (cl:not supplied-cancellation-token))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "CopyToAsync" destination))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM"
                    :class-name <type-str>
                    :method-name "CopyToAsync"
                    :supplied-args (cl:append (cl:list :destination destination) (cl:when supplied-buffer-size (cl:list :buffer-size buffer-size)) (cl:when supplied-cancellation-token (cl:list :cancellation-token cancellation-token)))))))

(cl:defun create-wait-handle (obj!)
  "Summary: Allocates a System.Threading.WaitHandle object.
Returns: A reference to the allocated .
"
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "CreateWaitHandle"))

(cl:defun dispose (obj! cl:&optional (disposing cl:nil supplied-disposing))
  "Master wrapper for System.IO.Stream.Dispose overloads. Dispatches at runtime.

Dispose() -> Void
  Summary: Releases all resources used by the System.IO.Stream.

Dispose(Boolean) -> Void
  Summary: Releases the unmanaged resources used by the System.IO.Stream and optionally releases the managed resources.
  Parameters:
    - disposing (System.Boolean): to release both managed and unmanaged resources; to release only unmanaged resources.
"
  (cl:cond
    ((cl:and supplied-disposing (cl:typep disposing 'cl:boolean))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "Dispose" disposing))
    ((cl:and (cl:not supplied-disposing))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "Dispose"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM"
                    :class-name <type-str>
                    :method-name "Dispose"
                    :supplied-args (cl:append (cl:when supplied-disposing (cl:list :disposing disposing)))))))

(cl:defun dispose-async (obj!)
  "Summary: Asynchronously releases the unmanaged resources used by the System.IO.Stream.
Returns: A task that represents the asynchronous dispose operation.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "DisposeAsync"))

(cl:defun end-read (obj! async-result)
  "Summary: Waits for the pending asynchronous read to complete. (Consider using System.IO.Stream.ReadAsync(System.Byte[],System.Int32,System.Int32) instead.)
Returns: The number of bytes read from the stream, between zero (0) and the number of bytes requested. ReadAsync returns zero (0) only if zero bytes were requested or if no more bytes will be available because it's at the end of the stream; otherwise, read operations do not complete until at least one byte is available. If zero bytes are requested, read operations may complete immediately or may not complete until at least one byte is available (but without consuming any data).
Parameters:
  - async-result (System.IAsyncResult): The reference to the pending asynchronous request to finish.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "EndRead" async-result))

(cl:defun end-write (obj! async-result)
  "Summary: Ends an asynchronous write operation. (Consider using System.IO.Stream.WriteAsync(System.Byte[],System.Int32,System.Int32) instead.)
Parameters:
  - async-result (System.IAsyncResult): A reference to the outstanding asynchronous I/O request.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "EndWrite" async-result))

(cl:defun flush (obj!)
  "Summary: When overridden in a derived class, clears all buffers for this stream and causes any buffered data to be written to the underlying device.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "Flush"))

(cl:defun flush-async (obj! cl:&optional (cancellation-token cl:nil supplied-cancellation-token))
  "Master wrapper for System.IO.Stream.FlushAsync overloads. Dispatches at runtime.

FlushAsync() -> Task
  Summary: Asynchronously clears all buffers for this stream and causes any buffered data to be written to the underlying device.
  Returns: A task that represents the asynchronous flush operation.

FlushAsync(CancellationToken) -> Task
  Summary: Asynchronously clears all buffers for this stream, causes any buffered data to be written to the underlying device, and monitors cancellation requests.
  Returns: A task that represents the asynchronous flush operation.
  Parameters:
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests. The default value is System.Threading.CancellationToken.None.
"
  (cl:cond
    ((cl:and supplied-cancellation-token (cl:or (cl:null cancellation-token) (dotnet:is-instance-of cancellation-token "System.Threading.CancellationToken")))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "FlushAsync" cancellation-token))
    ((cl:and (cl:not supplied-cancellation-token))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "FlushAsync"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM"
                    :class-name <type-str>
                    :method-name "FlushAsync"
                    :supplied-args (cl:append (cl:when supplied-cancellation-token (cl:list :cancellation-token cancellation-token)))))))

(cl:defun object-invariant (obj!)
  "Summary: Provides support for a System.Diagnostics.Contracts.Contract.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "ObjectInvariant"))

(cl:defun read (obj! buffer cl:&optional (offset cl:nil supplied-offset) (count cl:nil supplied-count))
  "Master wrapper for System.IO.Stream.Read overloads. Dispatches at runtime.

Read(Byte]) -> Int32
  Summary: When overridden in a derived class, reads a sequence of bytes from the current stream and advances the position within the stream by the number of bytes read.
  Returns: The total number of bytes read into the buffer. This can be less than the size of the buffer if that many bytes are not currently available, or zero (0) if the buffer's length is zero or the end of the stream has been reached.
  Parameters:
    - buffer (System.Span`1[System.Byte]): A region of memory. When this method returns, the contents of this region are replaced by the bytes read from the current source.

Read(Byte[], Int32, Int32) -> Int32
  Summary: When overridden in a derived class, reads a sequence of bytes from the current stream and advances the position within the stream by the number of bytes read.
  Returns: The total number of bytes read into the buffer. This can be less than the number of bytes requested if that many bytes are not currently available, or zero (0) if count is 0 or the end of the stream has been reached.
  Parameters:
    - buffer (System.Byte[]): An array of bytes. When this method returns, the buffer contains the specified byte array with the values between offset and (offset + count - 1) replaced by the bytes read from the current source.
    - offset (System.Int32): The zero-based byte offset in buffer at which to begin storing the data read from the current stream.
    - count (System.Int32): The maximum number of bytes to be read from the current stream.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Byte[]")) supplied-offset (cl:numberp offset) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "Read" buffer offset count))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Span`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-offset) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "Read" buffer))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM"
                    :class-name <type-str>
                    :method-name "Read"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:when supplied-offset (cl:list :offset offset)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun read-async (obj! buffer cancellation-token cl:&optional (count cl:nil supplied-count) (cancellation-token2 cl:nil supplied-cancellation-token2))
  "Master wrapper for System.IO.Stream.ReadAsync overloads. Dispatches at runtime.

ReadAsync(Byte], CancellationToken = default(System.Threading.CancellationToken) [C# default of type System.Threading.CancellationToken -- not representable in Lisp, must be supplied]) -> Int32]
  Summary: Asynchronously reads a sequence of bytes from the current stream, advances the position within the stream by the number of bytes read, and monitors cancellation requests.
  Returns: A task that represents the asynchronous read operation. The value of its System.Threading.Tasks.ValueTask`1.Result property contains the total number of bytes read into the buffer. The result value can be less than the length of the buffer if that many bytes are not currently available, or it can be 0 (zero) if the length of the buffer is 0 or if the end of the stream has been reached.
  Parameters:
    - buffer (System.Memory`1[System.Byte]): The region of memory to write the data into.
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests. The default value is System.Threading.CancellationToken.None.

ReadAsync(Byte[], Int32, Int32) -> Int32]
  Summary: Asynchronously reads a sequence of bytes from the current stream and advances the position within the stream by the number of bytes read.
  Returns: A task that represents the asynchronous read operation. The value of the TResult parameter contains the total number of bytes read into the buffer. The result value can be less than the number of bytes requested if the number of bytes currently available is less than the requested number, or it can be 0 (zero) if count is 0 or if the end of the stream has been reached.
  Parameters:
    - buffer (System.Byte[]): The buffer to write the data into.
    - offset (System.Int32): The byte offset in buffer at which to begin writing data from the stream.
    - count (System.Int32): The maximum number of bytes to read.

ReadAsync(Byte[], Int32, Int32, CancellationToken) -> Int32]
  Summary: Asynchronously reads a sequence of bytes from the current stream, advances the position within the stream by the number of bytes read, and monitors cancellation requests.
  Returns: A task that represents the asynchronous read operation. The value of the TResult parameter contains the total number of bytes read into the buffer. The result value can be less than the number of bytes requested if the number of bytes currently available is less than the requested number, or it can be 0 (zero) if count is 0 or if the end of the stream has been reached.
  Parameters:
    - buffer (System.Byte[]): The buffer to write the data into.
    - offset (System.Int32): The byte offset in buffer at which to begin writing data from the stream.
    - count (System.Int32): The maximum number of bytes to read.
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests. The default value is System.Threading.CancellationToken.None.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Byte[]")) (cl:numberp cancellation-token) supplied-count (cl:numberp count) supplied-cancellation-token2 (cl:or (cl:null cancellation-token2) (dotnet:is-instance-of cancellation-token2 "System.Threading.CancellationToken")))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "ReadAsync" buffer cancellation-token count cancellation-token2))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Byte[]")) (cl:numberp cancellation-token) supplied-count (cl:numberp count) (cl:not supplied-cancellation-token2))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "ReadAsync" buffer cancellation-token count))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Memory`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null cancellation-token) (dotnet:is-instance-of cancellation-token "System.Threading.CancellationToken")) (cl:not supplied-count) (cl:not supplied-cancellation-token2))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "ReadAsync" buffer cancellation-token))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM"
                    :class-name <type-str>
                    :method-name "ReadAsync"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:list :cancellation-token cancellation-token) (cl:when supplied-count (cl:list :count count)) (cl:when supplied-cancellation-token2 (cl:list :cancellation-token2 cancellation-token2)))))))

(cl:defun read-at-least (obj! buffer minimum-bytes cl:&key (throw-on-end-of-stream cl:t supplied-throw-on-end-of-stream))
  "Master wrapper for System.IO.Stream.ReadAtLeast overloads. Dispatches at runtime.

ReadAtLeast(Byte], Int32, Boolean = T) -> Int32
  Summary: Reads at least a minimum number of bytes from the current stream and advances the position within the stream by the number of bytes read.
  Returns: The total number of bytes read into the buffer. This is guaranteed to be greater than or equal to minimumBytes when throwOnEndOfStream is . This will be less than minimumBytes when the end of the stream is reached and throwOnEndOfStream is . This can be less than the number of bytes allocated in the buffer if that many bytes are not currently available.
  Parameters:
    - buffer (System.Span`1[System.Byte]): A region of memory. When this method returns, the contents of this region are replaced by the bytes read from the current stream.
    - minimum-bytes (System.Int32): The minimum number of bytes to read into the buffer.
    - throw-on-end-of-stream (System.Boolean): to throw an exception if the end of the stream is reached before reading minimumBytes of bytes; to return less than minimumBytes when the end of the stream is reached. The default is .
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Span`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:numberp minimum-bytes) (cl:or (cl:not supplied-throw-on-end-of-stream) (cl:typep throw-on-end-of-stream 'cl:boolean)))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "ReadAtLeast" buffer minimum-bytes (cl:if supplied-throw-on-end-of-stream throw-on-end-of-stream cl:t)))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM"
                    :class-name <type-str>
                    :method-name "ReadAtLeast"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:list :minimum-bytes minimum-bytes) (cl:when supplied-throw-on-end-of-stream (cl:list :throw-on-end-of-stream throw-on-end-of-stream)))))))

(cl:defun read-at-least-async (obj! buffer minimum-bytes cl:&key (throw-on-end-of-stream cl:t supplied-throw-on-end-of-stream) (cancellation-token cl:nil supplied-cancellation-token))
  "Master wrapper for System.IO.Stream.ReadAtLeastAsync overloads. Dispatches at runtime.

ReadAtLeastAsync(Byte], Int32, Boolean = T, CancellationToken = default(System.Threading.CancellationToken) [C# default of type System.Threading.CancellationToken -- not representable in Lisp, must be supplied]) -> Int32]
  Summary: Asynchronously reads at least a minimum number of bytes from the current stream, advances the position within the stream by the number of bytes read, and monitors cancellation requests.
  Returns: A task that represents the asynchronous read operation. The value of its System.Threading.Tasks.ValueTask`1.Result property contains the total number of bytes read into the buffer. This is guaranteed to be greater than or equal to minimumBytes when throwOnEndOfStream is . This will be less than minimumBytes when the end of the stream is reached and throwOnEndOfStream is . This can be less than the number of bytes allocated in the buffer if that many bytes are not currently available.
  Parameters:
    - buffer (System.Memory`1[System.Byte]): The region of memory to write the data into.
    - minimum-bytes (System.Int32): The minimum number of bytes to read into the buffer.
    - throw-on-end-of-stream (System.Boolean): to throw an exception if the end of the stream is reached before reading minimumBytes of bytes; to return less than minimumBytes when the end of the stream is reached. The default is .
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Memory`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:numberp minimum-bytes) (cl:or (cl:not supplied-throw-on-end-of-stream) (cl:typep throw-on-end-of-stream 'cl:boolean)) supplied-cancellation-token (cl:or (cl:null cancellation-token) (dotnet:is-instance-of cancellation-token "System.Threading.CancellationToken")))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "ReadAtLeastAsync" buffer minimum-bytes (cl:if supplied-throw-on-end-of-stream throw-on-end-of-stream cl:t) cancellation-token))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM"
                    :class-name <type-str>
                    :method-name "ReadAtLeastAsync"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:list :minimum-bytes minimum-bytes) (cl:when supplied-throw-on-end-of-stream (cl:list :throw-on-end-of-stream throw-on-end-of-stream)) (cl:when supplied-cancellation-token (cl:list :cancellation-token cancellation-token)))))))

(cl:defun read-byte (obj!)
  "Summary: Reads a byte from the stream and advances the position within the stream by one byte, or returns -1 if at the end of the stream.
Returns: The unsigned byte cast to an System.Int32, or -1 if at the end of the stream.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "ReadByte"))

(cl:defun read-exactly (obj! buffer cl:&optional (offset cl:nil supplied-offset) (count cl:nil supplied-count))
  "Master wrapper for System.IO.Stream.ReadExactly overloads. Dispatches at runtime.

ReadExactly(Byte]) -> Void
  Summary: Reads bytes from the current stream and advances the position within the stream until the buffer is filled.
  Parameters:
    - buffer (System.Span`1[System.Byte]): A region of memory. When this method returns, the contents of this region are replaced by the bytes read from the current stream.

ReadExactly(Byte[], Int32, Int32) -> Void
  Summary: Reads count number of bytes from the current stream and advances the position within the stream.
  Parameters:
    - buffer (System.Byte[]): An array of bytes. When this method returns, the buffer contains the specified byte array with the values between offset and (offset + count - 1) replaced by the bytes read from the current stream.
    - offset (System.Int32): The byte offset in buffer at which to begin storing the data read from the current stream.
    - count (System.Int32): The number of bytes to be read from the current stream.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Byte[]")) supplied-offset (cl:numberp offset) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "ReadExactly" buffer offset count))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Span`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-offset) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "ReadExactly" buffer))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM"
                    :class-name <type-str>
                    :method-name "ReadExactly"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:when supplied-offset (cl:list :offset offset)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun read-exactly-async (obj! buffer cancellation-token cl:&optional (count cl:nil supplied-count) (cancellation-token2 cl:nil supplied-cancellation-token2))
  "Master wrapper for System.IO.Stream.ReadExactlyAsync overloads. Dispatches at runtime.

ReadExactlyAsync(Byte], CancellationToken = default(System.Threading.CancellationToken) [C# default of type System.Threading.CancellationToken -- not representable in Lisp, must be supplied]) -> ValueTask
  Summary: Asynchronously reads bytes from the current stream, advances the position within the stream until the buffer is filled, and monitors cancellation requests.
  Returns: A task that represents the asynchronous read operation.
  Parameters:
    - buffer (System.Memory`1[System.Byte]): The buffer to write the data into.
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests.

ReadExactlyAsync(Byte[], Int32, Int32, CancellationToken = default(System.Threading.CancellationToken) [C# default of type System.Threading.CancellationToken -- not representable in Lisp, must be supplied]) -> ValueTask
  Summary: Asynchronously reads count number of bytes from the current stream, advances the position within the stream, and monitors cancellation requests.
  Returns: A task that represents the asynchronous read operation.
  Parameters:
    - buffer (System.Byte[]): The buffer to write the data into.
    - offset (System.Int32): The byte offset in buffer at which to begin writing data from the stream.
    - count (System.Int32): The number of bytes to be read from the current stream.
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Byte[]")) (cl:numberp cancellation-token) supplied-count (cl:numberp count) supplied-cancellation-token2 (cl:or (cl:null cancellation-token2) (dotnet:is-instance-of cancellation-token2 "System.Threading.CancellationToken")))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "ReadExactlyAsync" buffer cancellation-token count cancellation-token2))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Memory`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null cancellation-token) (dotnet:is-instance-of cancellation-token "System.Threading.CancellationToken")) (cl:not supplied-count) (cl:not supplied-cancellation-token2))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "ReadExactlyAsync" buffer cancellation-token))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM"
                    :class-name <type-str>
                    :method-name "ReadExactlyAsync"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:list :cancellation-token cancellation-token) (cl:when supplied-count (cl:list :count count)) (cl:when supplied-cancellation-token2 (cl:list :cancellation-token2 cancellation-token2)))))))

(cl:defun seek (obj! offset origin)
  "Summary: When overridden in a derived class, sets the position within the current stream.
Returns: The new position within the current stream.
Parameters:
  - offset (System.Int64): A byte offset relative to the origin parameter.
  - origin (System.IO.SeekOrigin): A value of type System.IO.SeekOrigin indicating the reference point used to obtain the new position.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "Seek" offset origin))

(cl:defun set-length (obj! value)
  "Summary: When overridden in a derived class, sets the length of the current stream.
Parameters:
  - value (System.Int64): The desired length of the current stream in bytes.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "SetLength" value))

(cl:defun synchronized (stream)
  "Summary: Creates a thread-safe (synchronized) wrapper around the specified System.IO.Stream object.
Returns: A thread-safe System.IO.Stream object.
Parameters:
  - stream (System.IO.Stream): The System.IO.Stream object to synchronize.
"
  (dotnet:static <type-str> "Synchronized" (cl:the (dotnet "System.IO.Stream") stream)))

(cl:defun validate-buffer-arguments (buffer offset count)
  "Summary: Validates arguments provided to reading and writing methods on System.IO.Stream.
Parameters:
  - buffer (System.Byte[]): The array \"buffer\" argument passed to the reading or writing method.
  - offset (System.Int32): The integer \"offset\" argument passed to the reading or writing method.
  - count (System.Int32): The integer \"count\" argument passed to the reading or writing method.
"
  (dotnet:static <type-str> "ValidateBufferArguments" (cl:the (dotnet "System.Byte[]") buffer) (cl:the (dotnet "System.Int32") offset) (cl:the (dotnet "System.Int32") count)))

(cl:defun validate-copy-to-arguments (destination buffer-size)
  "Summary: Validates arguments provided to the System.IO.Stream.CopyTo(System.IO.Stream,System.Int32) or System.IO.Stream.CopyToAsync(System.IO.Stream,System.Int32,System.Threading.CancellationToken) methods.
Parameters:
  - destination (System.IO.Stream): The System.IO.Stream \"destination\" argument passed to the copy method.
  - buffer-size (System.Int32): The integer \"bufferSize\" argument passed to the copy method.
"
  (dotnet:static <type-str> "ValidateCopyToArguments" (cl:the (dotnet "System.IO.Stream") destination) (cl:the (dotnet "System.Int32") buffer-size)))

(cl:defun write (obj! buffer cl:&optional (offset cl:nil supplied-offset) (count cl:nil supplied-count))
  "Master wrapper for System.IO.Stream.Write overloads. Dispatches at runtime.

Write(Byte]) -> Void
  Summary: When overridden in a derived class, writes a sequence of bytes to the current stream and advances the current position within this stream by the number of bytes written.
  Parameters:
    - buffer (System.ReadOnlySpan`1[System.Byte]): A region of memory. This method copies the contents of this region to the current stream.

Write(Byte[], Int32, Int32) -> Void
  Summary: When overridden in a derived class, writes a sequence of bytes to the current stream and advances the current position within this stream by the number of bytes written.
  Parameters:
    - buffer (System.Byte[]): An array of bytes. This method copies count bytes from buffer to the current stream.
    - offset (System.Int32): The zero-based byte offset in buffer at which to begin copying bytes to the current stream.
    - count (System.Int32): The number of bytes to be written to the current stream.
"
  (cl:cond
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Byte[]")) supplied-offset (cl:numberp offset) supplied-count (cl:numberp count))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "Write" buffer offset count))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.ReadOnlySpan`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:not supplied-offset) (cl:not supplied-count))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "Write" buffer))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM"
                    :class-name <type-str>
                    :method-name "Write"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:when supplied-offset (cl:list :offset offset)) (cl:when supplied-count (cl:list :count count)))))))

(cl:defun write-async (obj! buffer cancellation-token cl:&optional (count cl:nil supplied-count) (cancellation-token2 cl:nil supplied-cancellation-token2))
  "Master wrapper for System.IO.Stream.WriteAsync overloads. Dispatches at runtime.

WriteAsync(Byte], CancellationToken = default(System.Threading.CancellationToken) [C# default of type System.Threading.CancellationToken -- not representable in Lisp, must be supplied]) -> ValueTask
  Summary: Asynchronously writes a sequence of bytes to the current stream, advances the current position within this stream by the number of bytes written, and monitors cancellation requests.
  Returns: A task that represents the asynchronous write operation.
  Parameters:
    - buffer (System.ReadOnlyMemory`1[System.Byte]): The region of memory to write data from.
    - cancellation-token (System.Threading.CancellationToken): The token to monitor for cancellation requests. The default value is System.Threading.CancellationToken.None.

WriteAsync(Byte[], Int32, Int32) -> Task
  Summary: Asynchronously writes a sequence of bytes to the current stream and advances the current position within this stream by the number of bytes written.
  Returns: A task that represents the asynchronous write operation.
  Parameters:
    - buffer (System.Byte[]): The buffer to write data from.
    - offset (System.Int32): The zero-based byte offset in buffer from which to begin copying bytes to the stream.
    - count (System.Int32): The maximum number of bytes to write.

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
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "WriteAsync" buffer cancellation-token count cancellation-token2))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.Byte[]")) (cl:numberp cancellation-token) supplied-count (cl:numberp count) (cl:not supplied-cancellation-token2))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "WriteAsync" buffer cancellation-token count))
    ((cl:and (cl:or (cl:null buffer) (dotnet:is-instance-of buffer "System.ReadOnlyMemory`1[[System.Byte, System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]], System.Private.CoreLib, Version=10.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e")) (cl:or (cl:null cancellation-token) (dotnet:is-instance-of cancellation-token "System.Threading.CancellationToken")) (cl:not supplied-count) (cl:not supplied-cancellation-token2))
     (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "WriteAsync" buffer cancellation-token))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-IO-STREAM"
                    :class-name <type-str>
                    :method-name "WriteAsync"
                    :supplied-args (cl:append (cl:list :buffer buffer) (cl:list :cancellation-token cancellation-token) (cl:when supplied-count (cl:list :count count)) (cl:when supplied-cancellation-token2 (cl:list :cancellation-token2 cancellation-token2)))))))

(cl:defun write-byte (obj! value)
  "Summary: Writes a byte to the current position in the stream and advances the position within the stream by one byte.
Parameters:
  - value (System.Byte): The byte to write to the stream.
"
  (dotnet:invoke (cl:the (dotnet "System.IO.Stream") obj!) "WriteByte" value))

