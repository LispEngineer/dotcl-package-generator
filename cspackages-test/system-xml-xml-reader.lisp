;;; Generated automatically. Do not edit.
;;; Class: System.Xml.XmlReader
;;; Generator Version: 54
;;; Creation Date: 2026-07-19T20:42:53Z
;;; Options: --export-interfaces

(cl:in-package :system-xml-xml-reader)

(cl:define-symbol-macro <type> (dotnet:resolve-type "System.Xml.XmlReader"))
(cl:defconstant <type-str> "System.Xml.XmlReader")
(cl:defconstant <creation> "2026-07-19T20:42:53Z")
(cl:defconstant <version> 54)

(cl:defun new ()
  "Summary: Initializes a new instance of the class.
"
  (dotnet:new <type-str>))

(cl:defun attribute-count (obj!)
  "When overridden in a derived class, gets the number of attributes on the current node."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_AttributeCount"))

(cl:defun base-uri (obj!)
  "When overridden in a derived class, gets the base URI of the current node."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_BaseURI"))

(cl:defun can-read-binary-content (obj!)
  "Gets a value indicating whether the System.Xml.XmlReader implements the binary content read methods."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_CanReadBinaryContent"))

(cl:defun can-read-value-chunk (obj!)
  "Gets a value indicating whether the System.Xml.XmlReader implements the System.Xml.XmlReader.ReadValueChunk(System.Char[],System.Int32,System.Int32) method."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_CanReadValueChunk"))

(cl:defun can-resolve-entity (obj!)
  "Gets a value indicating whether this reader can parse and resolve entities."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_CanResolveEntity"))

(cl:defun depth (obj!)
  "When overridden in a derived class, gets the depth of the current node in the XML document."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_Depth"))

(cl:defun eof (obj!)
  "When overridden in a derived class, gets a value indicating whether the reader is positioned at the end of the stream."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_EOF"))

(cl:defun has-attributes (obj!)
  "Gets a value indicating whether the current node has any attributes."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_HasAttributes"))

(cl:defun has-value (obj!)
  "When overridden in a derived class, gets a value indicating whether the current node can have a System.Xml.XmlReader.Value."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_HasValue"))

(cl:defun default? (obj!)
  "When overridden in a derived class, gets a value indicating whether the current node is an attribute that was generated from the default value defined in the DTD or schema."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_IsDefault"))

(cl:defun empty-element? (obj!)
  "When overridden in a derived class, gets a value indicating whether the current node is an empty element (for example, <MyElement/>)."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_IsEmptyElement"))

;; Note: System.Xml.XmlReader's indexer "Item" has multiple overloaded signatures,
;; which are not yet supported:
;;   Item[Int32] -> String
;;   Item[String] -> String
;;   Item[String, String] -> String

(cl:defun local-name (obj!)
  "When overridden in a derived class, gets the local name of the current node."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_LocalName"))

(cl:defun name (obj!)
  "When overridden in a derived class, gets the qualified name of the current node."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_Name"))

(cl:defun namespace-uri (obj!)
  "When overridden in a derived class, gets the namespace URI (as defined in the W3C Namespace specification) of the node on which the reader is positioned."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_NamespaceURI"))

(cl:defun name-table (obj!)
  "When overridden in a derived class, gets the System.Xml.XmlNameTable associated with this implementation."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_NameTable"))

(cl:defun node-type (obj!)
  "When overridden in a derived class, gets the type of the current node."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_NodeType"))

(cl:defun prefix (obj!)
  "When overridden in a derived class, gets the namespace prefix associated with the current node."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_Prefix"))

(cl:defun quote-char (obj!)
  "When overridden in a derived class, gets the quotation mark character used to enclose the value of an attribute node."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_QuoteChar"))

(cl:defun read-state (obj!)
  "When overridden in a derived class, gets the state of the reader."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_ReadState"))

(cl:defun schema-info (obj!)
  "Gets the schema information that has been assigned to the current node as a result of schema validation."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_SchemaInfo"))

(cl:defun settings (obj!)
  "Gets the System.Xml.XmlReaderSettings object used to create this System.Xml.XmlReader instance."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_Settings"))

(cl:defun value (obj!)
  "When overridden in a derived class, gets the text value of the current node."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_Value"))

(cl:defun value-type (obj!)
  "Gets The Common Language Runtime (CLR) type for the current node."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_ValueType"))

(cl:defun xml-lang (obj!)
  "When overridden in a derived class, gets the current scope."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_XmlLang"))

(cl:defun xml-space (obj!)
  "When overridden in a derived class, gets the current scope."
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "get_XmlSpace"))

(cl:defun close (obj!)
  "Summary: When overridden in a derived class, changes the System.Xml.XmlReader.ReadState to System.Xml.ReadState.Closed.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "Close"))

(cl:defun create (input-uri cl:&optional (settings cl:nil supplied-settings) (input-context cl:nil supplied-input-context))
  "Master wrapper for System.Xml.XmlReader.Create overloads. Dispatches at runtime.

Create(String) -> XmlReader
  Summary: Creates a new System.Xml.XmlReader instance with specified URI.
  Returns: An object that is used to read the XML data in the stream.
  Parameters:
    - input-uri (System.String): The URI for the file that contains the XML data. The System.Xml.XmlUrlResolver class is used to convert the path to a canonical data representation.

Create(Stream) -> XmlReader
  Summary: Creates a new System.Xml.XmlReader instance using the specified stream with default settings.
  Returns: An object that is used to read the XML data in the stream.
  Parameters:
    - input (System.IO.Stream): The stream that contains the XML data. The System.Xml.XmlReader scans the first bytes of the stream looking for a byte order mark or other sign of encoding. When encoding is determined, the encoding is used to continue reading the stream, and processing continues parsing the input as a stream of (Unicode) characters.

Create(TextReader) -> XmlReader
  Summary: Creates a new System.Xml.XmlReader instance by using the specified text reader.
  Returns: An object that is used to read the XML data in the stream.
  Parameters:
    - input (System.IO.TextReader): The text reader from which to read the XML data. A text reader returns a stream of Unicode characters, so the encoding specified in the XML declaration is not used by the XML reader to decode the data stream.

Create(String, XmlReaderSettings) -> XmlReader
  Summary: Creates a new System.Xml.XmlReader instance by using the specified URI and settings.
  Returns: An object that is used to read the XML data in the stream.
  Parameters:
    - input-uri (System.String): The URI for the file containing the XML data. The System.Xml.XmlResolver object on the System.Xml.XmlReaderSettings object is used to convert the path to a canonical data representation. If System.Xml.XmlReaderSettings.XmlResolver is , a new System.Xml.XmlUrlResolver object is used.
    - settings (System.Xml.XmlReaderSettings): The settings for the new System.Xml.XmlReader instance. This value can be .

Create(Stream, XmlReaderSettings) -> XmlReader
  Summary: Creates a new System.Xml.XmlReader instance with the specified stream and settings.
  Returns: An object that is used to read the XML data in the stream.
  Parameters:
    - input (System.IO.Stream): The stream that contains the XML data. The System.Xml.XmlReader scans the first bytes of the stream looking for a byte order mark or other sign of encoding. When encoding is determined, the encoding is used to continue reading the stream, and processing continues parsing the input as a stream of (Unicode) characters.
    - settings (System.Xml.XmlReaderSettings): The settings for the new System.Xml.XmlReader instance. This value can be .

Create(TextReader, XmlReaderSettings) -> XmlReader
  Summary: Creates a new System.Xml.XmlReader instance by using the specified text reader and settings.
  Returns: An object that is used to read the XML data in the stream.
  Parameters:
    - input (System.IO.TextReader): The text reader from which to read the XML data. A text reader returns a stream of Unicode characters, so the encoding specified in the XML declaration isn't used by the XML reader to decode the data stream.
    - settings (System.Xml.XmlReaderSettings): The settings for the new System.Xml.XmlReader. This value can be .

Create(XmlReader, XmlReaderSettings) -> XmlReader
  Summary: Creates a new System.Xml.XmlReader instance by using the specified XML reader and settings.
  Returns: An object that is wrapped around the specified System.Xml.XmlReader object.
  Parameters:
    - reader (System.Xml.XmlReader): The object that you want to use as the underlying XML reader.
    - settings (System.Xml.XmlReaderSettings): The settings for the new System.Xml.XmlReader instance. The conformance level of the System.Xml.XmlReaderSettings object must either match the conformance level of the underlying reader, or it must be set to System.Xml.ConformanceLevel.Auto.

Create(String, XmlReaderSettings, XmlParserContext) -> XmlReader
  Summary: Creates a new System.Xml.XmlReader instance by using the specified URI, settings, and context information for parsing.
  Returns: An object that is used to read the XML data in the stream.
  Parameters:
    - input-uri (System.String): The URI for the file containing the XML data. The System.Xml.XmlResolver object on the System.Xml.XmlReaderSettings object is used to convert the path to a canonical data representation. If System.Xml.XmlReaderSettings.XmlResolver is , a new System.Xml.XmlUrlResolver object is used.
    - settings (System.Xml.XmlReaderSettings): The settings for the new System.Xml.XmlReader instance. This value can be .
    - input-context (System.Xml.XmlParserContext): The context information required to parse the XML fragment. The context information can include the System.Xml.XmlNameTable to use, encoding, namespace scope, the current xml:lang and xml:space scope, base URI, and document type definition. This value can be .

Create(Stream, XmlReaderSettings, String) -> XmlReader
  Summary: Creates a new System.Xml.XmlReader instance using the specified stream, base URI, and settings.
  Returns: An object that is used to read the XML data in the stream.
  Parameters:
    - input (System.IO.Stream): The stream that contains the XML data. The System.Xml.XmlReader scans the first bytes of the stream looking for a byte order mark or other sign of encoding. When encoding is determined, the encoding is used to continue reading the stream, and processing continues parsing the input as a stream of (Unicode) characters.
    - settings (System.Xml.XmlReaderSettings): The settings for the new System.Xml.XmlReader instance. This value can be .
    - base-uri (System.String): The base URI for the entity or document being read. This value can be . Security Note The base URI is used to resolve the relative URI of the XML document. Do not use a base URI from an untrusted source.

Create(Stream, XmlReaderSettings, XmlParserContext) -> XmlReader
  Summary: Creates a new System.Xml.XmlReader instance using the specified stream, settings, and context information for parsing.
  Returns: An object that is used to read the XML data in the stream.
  Parameters:
    - input (System.IO.Stream): The stream that contains the XML data. The System.Xml.XmlReader scans the first bytes of the stream looking for a byte order mark or other sign of encoding. When encoding is determined, the encoding is used to continue reading the stream, and processing continues parsing the input as a stream of (Unicode) characters.
    - settings (System.Xml.XmlReaderSettings): The settings for the new System.Xml.XmlReader instance. This value can be .
    - input-context (System.Xml.XmlParserContext): The context information required to parse the XML fragment. The context information can include the System.Xml.XmlNameTable to use, encoding, namespace scope, the current xml:lang and xml:space scope, base URI, and document type definition. This value can be .

Create(TextReader, XmlReaderSettings, String) -> XmlReader
  Summary: Creates a new System.Xml.XmlReader instance by using the specified text reader, settings, and base URI.
  Returns: An object that is used to read the XML data in the stream.
  Parameters:
    - input (System.IO.TextReader): The text reader from which to read the XML data. A text reader returns a stream of Unicode characters, so the encoding specified in the XML declaration isn't used by the System.Xml.XmlReader to decode the data stream.
    - settings (System.Xml.XmlReaderSettings): The settings for the new System.Xml.XmlReader instance. This value can be .
    - base-uri (System.String): The base URI for the entity or document being read. This value can be . Security Note The base URI is used to resolve the relative URI of the XML document. Do not use a base URI from an untrusted source.

Create(TextReader, XmlReaderSettings, XmlParserContext) -> XmlReader
  Summary: Creates a new System.Xml.XmlReader instance by using the specified text reader, settings, and context information for parsing.
  Returns: An object that is used to read the XML data in the stream.
  Parameters:
    - input (System.IO.TextReader): The text reader from which to read the XML data. A text reader returns a stream of Unicode characters, so the encoding specified in the XML declaration isn't used by the XML reader to decode the data stream.
    - settings (System.Xml.XmlReaderSettings): The settings for the new System.Xml.XmlReader instance. This value can be .
    - input-context (System.Xml.XmlParserContext): The context information required to parse the XML fragment. The context information can include the System.Xml.XmlNameTable to use, encoding, namespace scope, the current xml:lang and xml:space scope, base URI, and document type definition. This value can be .
"
  (cl:cond
    ((cl:and (cl:stringp input-uri) supplied-settings (cl:or (cl:null settings) (dotnet:is-instance-of settings "System.Xml.XmlReaderSettings")) supplied-input-context (cl:or (cl:null input-context) (dotnet:is-instance-of input-context "System.Xml.XmlParserContext")))
     (dotnet:static <type-str> "Create" input-uri settings input-context))
    ((cl:and (cl:or (cl:null input-uri) (dotnet:is-instance-of input-uri "System.IO.Stream")) supplied-settings (cl:or (cl:null settings) (dotnet:is-instance-of settings "System.Xml.XmlReaderSettings")) supplied-input-context (cl:stringp input-context))
     (dotnet:static <type-str> "Create" input-uri settings input-context))
    ((cl:and (cl:or (cl:null input-uri) (dotnet:is-instance-of input-uri "System.IO.Stream")) supplied-settings (cl:or (cl:null settings) (dotnet:is-instance-of settings "System.Xml.XmlReaderSettings")) supplied-input-context (cl:or (cl:null input-context) (dotnet:is-instance-of input-context "System.Xml.XmlParserContext")))
     (dotnet:static <type-str> "Create" input-uri settings input-context))
    ((cl:and (cl:or (cl:null input-uri) (dotnet:is-instance-of input-uri "System.IO.TextReader")) supplied-settings (cl:or (cl:null settings) (dotnet:is-instance-of settings "System.Xml.XmlReaderSettings")) supplied-input-context (cl:stringp input-context))
     (dotnet:static <type-str> "Create" input-uri settings input-context))
    ((cl:and (cl:or (cl:null input-uri) (dotnet:is-instance-of input-uri "System.IO.TextReader")) supplied-settings (cl:or (cl:null settings) (dotnet:is-instance-of settings "System.Xml.XmlReaderSettings")) supplied-input-context (cl:or (cl:null input-context) (dotnet:is-instance-of input-context "System.Xml.XmlParserContext")))
     (dotnet:static <type-str> "Create" input-uri settings input-context))
    ((cl:and (cl:stringp input-uri) supplied-settings (cl:or (cl:null settings) (dotnet:is-instance-of settings "System.Xml.XmlReaderSettings")) (cl:not supplied-input-context))
     (dotnet:static <type-str> "Create" input-uri settings))
    ((cl:and (cl:or (cl:null input-uri) (dotnet:is-instance-of input-uri "System.IO.Stream")) supplied-settings (cl:or (cl:null settings) (dotnet:is-instance-of settings "System.Xml.XmlReaderSettings")) (cl:not supplied-input-context))
     (dotnet:static <type-str> "Create" input-uri settings))
    ((cl:and (cl:or (cl:null input-uri) (dotnet:is-instance-of input-uri "System.IO.TextReader")) supplied-settings (cl:or (cl:null settings) (dotnet:is-instance-of settings "System.Xml.XmlReaderSettings")) (cl:not supplied-input-context))
     (dotnet:static <type-str> "Create" input-uri settings))
    ((cl:and (cl:or (cl:null input-uri) (dotnet:is-instance-of input-uri "System.Xml.XmlReader")) supplied-settings (cl:or (cl:null settings) (dotnet:is-instance-of settings "System.Xml.XmlReaderSettings")) (cl:not supplied-input-context))
     (dotnet:static <type-str> "Create" input-uri settings))
    ((cl:and (cl:stringp input-uri) (cl:not supplied-settings) (cl:not supplied-input-context))
     (dotnet:static <type-str> "Create" input-uri))
    ((cl:and (cl:or (cl:null input-uri) (dotnet:is-instance-of input-uri "System.IO.Stream")) (cl:not supplied-settings) (cl:not supplied-input-context))
     (dotnet:static <type-str> "Create" input-uri))
    ((cl:and (cl:or (cl:null input-uri) (dotnet:is-instance-of input-uri "System.IO.TextReader")) (cl:not supplied-settings) (cl:not supplied-input-context))
     (dotnet:static <type-str> "Create" input-uri))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "Create"
                    :supplied-args (cl:append (cl:list :input-uri input-uri) (cl:when supplied-settings (cl:list :settings settings)) (cl:when supplied-input-context (cl:list :input-context input-context)))))))

(cl:defun dispose (obj! cl:&optional (disposing cl:nil supplied-disposing))
  "Master wrapper for System.Xml.XmlReader.Dispose overloads. Dispatches at runtime.

Dispose() -> Void
  Summary: Releases all resources used by the current instance of the System.Xml.XmlReader class.

Dispose(Boolean) -> Void
  Summary: Releases the unmanaged resources used by the System.Xml.XmlReader and optionally releases the managed resources.
  Parameters:
    - disposing (System.Boolean): to release both managed and unmanaged resources; to release only unmanaged resources.
"
  (cl:cond
    ((cl:and supplied-disposing (cl:typep disposing 'cl:boolean))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "Dispose" disposing))
    ((cl:and (cl:not supplied-disposing))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "Dispose"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "Dispose"
                    :supplied-args (cl:append (cl:when supplied-disposing (cl:list :disposing disposing)))))))

(cl:defun get-attribute (obj! name cl:&optional (namespace-uri cl:nil supplied-namespace-uri))
  "Master wrapper for System.Xml.XmlReader.GetAttribute overloads. Dispatches at runtime.

GetAttribute(String) -> String
  Summary: When overridden in a derived class, gets the value of the attribute with the specified System.Xml.XmlReader.Name.
  Returns: The value of the specified attribute. If the attribute is not found or the value is , is returned.
  Parameters:
    - name (System.String): The qualified name of the attribute.

GetAttribute(Int32) -> String
  Summary: When overridden in a derived class, gets the value of the attribute with the specified index.
  Returns: The value of the specified attribute. This method does not move the reader.
  Parameters:
    - i (System.Int32): The index of the attribute. The index is zero-based. (The first attribute has index 0.)

GetAttribute(String, String) -> String
  Summary: When overridden in a derived class, gets the value of the attribute with the specified System.Xml.XmlReader.LocalName and System.Xml.XmlReader.NamespaceURI.
  Returns: The value of the specified attribute. If the attribute is not found or the value is , is returned. This method does not move the reader.
  Parameters:
    - name (System.String): The local name of the attribute.
    - namespace-uri (System.String): The namespace URI of the attribute.
"
  (cl:cond
    ((cl:and (cl:stringp name) supplied-namespace-uri (cl:stringp namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "GetAttribute" name namespace-uri))
    ((cl:and (cl:numberp name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "GetAttribute" name))
    ((cl:and (cl:stringp name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "GetAttribute" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "GetAttribute"
                    :supplied-args (cl:append (cl:list :name name) (cl:when supplied-namespace-uri (cl:list :namespace-uri namespace-uri)))))))

(cl:defun get-value-async (obj!)
  "Summary: Asynchronously gets the value of the current node.
Returns: The value of the current node.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "GetValueAsync"))

(cl:defun name? (str)
  "Summary: Returns a value indicating whether the string argument is a valid XML name.
Returns: if the name is valid; otherwise, .
Parameters:
  - str (System.String): The name to validate.
"
  (dotnet:static <type-str> "IsName" (cl:the (dotnet "System.String") str)))

(cl:defun name-token? (str)
  "Summary: Returns a value indicating whether or not the string argument is a valid XML name token.
Returns: if it is a valid name token; otherwise .
Parameters:
  - str (System.String): The name token to validate.
"
  (dotnet:static <type-str> "IsNameToken" (cl:the (dotnet "System.String") str)))

(cl:defun start-element? (obj! cl:&optional (name cl:nil supplied-name) (ns cl:nil supplied-ns))
  "Master wrapper for System.Xml.XmlReader.IsStartElement overloads. Dispatches at runtime.

IsStartElement() -> Boolean
  Summary: Calls System.Xml.XmlReader.MoveToContent and tests if the current content node is a start tag or empty element tag.
  Returns: if System.Xml.XmlReader.MoveToContent finds a start tag or empty element tag; if a node type other than was found.

IsStartElement(String) -> Boolean
  Summary: Calls System.Xml.XmlReader.MoveToContent and tests if the current content node is a start tag or empty element tag and if the System.Xml.XmlReader.Name property of the element found matches the given argument.
  Returns: if the resulting node is an element and the property matches the specified string. if a node type other than was found or if the element property does not match the specified string.
  Parameters:
    - name (System.String): The string matched against the property of the element found.

IsStartElement(String, String) -> Boolean
  Summary: Calls System.Xml.XmlReader.MoveToContent and tests if the current content node is a start tag or empty element tag and if the System.Xml.XmlReader.LocalName and System.Xml.XmlReader.NamespaceURI properties of the element found match the given strings.
  Returns: if the resulting node is an element. if a node type other than was found or if the and properties of the element do not match the specified strings.
  Parameters:
    - localname (System.String): The string to match against the property of the element found.
    - ns (System.String): The string to match against the property of the element found.
"
  (cl:cond
    ((cl:and supplied-name (cl:stringp name) supplied-ns (cl:stringp ns))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "IsStartElement" name ns))
    ((cl:and supplied-name (cl:stringp name) (cl:not supplied-ns))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "IsStartElement" name))
    ((cl:and (cl:not supplied-name) (cl:not supplied-ns))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "IsStartElement"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "IsStartElement"
                    :supplied-args (cl:append (cl:when supplied-name (cl:list :name name)) (cl:when supplied-ns (cl:list :ns ns)))))))

(cl:defun lookup-namespace (obj! prefix)
  "Summary: When overridden in a derived class, resolves a namespace prefix in the current element's scope.
Returns: The namespace URI to which the prefix maps or if no matching prefix is found.
Parameters:
  - prefix (System.String): The prefix whose namespace URI you want to resolve. To match the default namespace, pass an empty string.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "LookupNamespace" prefix))

(cl:defun move-to-attribute (obj! name cl:&optional (ns cl:nil supplied-ns))
  "Master wrapper for System.Xml.XmlReader.MoveToAttribute overloads. Dispatches at runtime.

MoveToAttribute(String) -> Boolean
  Summary: When overridden in a derived class, moves to the attribute with the specified System.Xml.XmlReader.Name.
  Returns: if the attribute is found; otherwise, . If , the reader's position does not change.
  Parameters:
    - name (System.String): The qualified name of the attribute.

MoveToAttribute(Int32) -> Void
  Summary: When overridden in a derived class, moves to the attribute with the specified index.
  Parameters:
    - i (System.Int32): The index of the attribute.

MoveToAttribute(String, String) -> Boolean
  Summary: When overridden in a derived class, moves to the attribute with the specified System.Xml.XmlReader.LocalName and System.Xml.XmlReader.NamespaceURI.
  Returns: if the attribute is found; otherwise, . If , the reader's position does not change.
  Parameters:
    - name (System.String): The local name of the attribute.
    - ns (System.String): The namespace URI of the attribute.
"
  (cl:cond
    ((cl:and (cl:stringp name) supplied-ns (cl:stringp ns))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "MoveToAttribute" name ns))
    ((cl:and (cl:numberp name) (cl:not supplied-ns))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "MoveToAttribute" name))
    ((cl:and (cl:stringp name) (cl:not supplied-ns))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "MoveToAttribute" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "MoveToAttribute"
                    :supplied-args (cl:append (cl:list :name name) (cl:when supplied-ns (cl:list :ns ns)))))))

(cl:defun move-to-content (obj!)
  "Summary: Checks whether the current node is a content (non-white space text, , , , , or ) node. If the node is not a content node, the reader skips ahead to the next content node or end of file. It skips over nodes of the following type: , , , , or .
Returns: The System.Xml.XmlReader.NodeType of the current node found by the method or if the reader has reached the end of the input stream.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "MoveToContent"))

(cl:defun move-to-content-async (obj!)
  "Summary: Asynchronously checks whether the current node is a content node. If the node is not a content node, the reader skips ahead to the next content node or end of file.
Returns: The System.Xml.XmlReader.NodeType of the current node found by the method or if the reader has reached the end of the input stream.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "MoveToContentAsync"))

(cl:defun move-to-element (obj!)
  "Summary: When overridden in a derived class, moves to the element that contains the current attribute node.
Returns: if the reader is positioned on an attribute (the reader moves to the element that owns the attribute); if the reader is not positioned on an attribute (the position of the reader does not change).
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "MoveToElement"))

(cl:defun move-to-first-attribute (obj!)
  "Summary: When overridden in a derived class, moves to the first attribute.
Returns: if an attribute exists (the reader moves to the first attribute); otherwise, (the position of the reader does not change).
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "MoveToFirstAttribute"))

(cl:defun move-to-next-attribute (obj!)
  "Summary: When overridden in a derived class, moves to the next attribute.
Returns: if there is a next attribute; if there are no more attributes.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "MoveToNextAttribute"))

(cl:defun read (obj!)
  "Summary: When overridden in a derived class, reads the next node from the stream.
Returns: if the next node was read successfully; otherwise, .
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "Read"))

(cl:defun read-async (obj!)
  "Summary: Asynchronously reads the next node from the stream.
Returns: if the next node was read successfully; if there are no more nodes to read.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadAsync"))

(cl:defun read-attribute-value (obj!)
  "Summary: When overridden in a derived class, parses the attribute value into one or more , , or nodes.
Returns: if there are nodes to return. if the reader is not positioned on an attribute node when the initial call is made or if all the attribute values have been read. An empty attribute, such as, misc=\"\", returns with a single node with a value of .
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadAttributeValue"))

(cl:defun read-content-as (obj! return-type namespace-resolver)
  "Summary: Reads the content as an object of the type specified.
Returns: The concatenated text content or attribute value converted to the requested type.
Parameters:
  - return-type (System.Type): The type of the value to be returned. Note With the release of the .NET Framework 3.5, the value of the returnType parameter can now be the System.DateTimeOffset type.
  - namespace-resolver (System.Xml.IXmlNamespaceResolver): An System.Xml.IXmlNamespaceResolver object that is used to resolve any namespace prefixes related to type conversion. For example, this can be used when converting an System.Xml.XmlQualifiedName object to an xs:string. This value can be .
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAs" return-type namespace-resolver))

(cl:defun read-content-as-async (obj! return-type namespace-resolver)
  "Summary: Asynchronously reads the content as an object of the type specified.
Returns: The concatenated text content or attribute value converted to the requested type.
Parameters:
  - return-type (System.Type): The type of the value to be returned.
  - namespace-resolver (System.Xml.IXmlNamespaceResolver): An System.Xml.IXmlNamespaceResolver object that is used to resolve any namespace prefixes related to type conversion.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsAsync" return-type namespace-resolver))

(cl:defun read-content-as-base64 (obj! buffer index count)
  "Summary: Reads the content and returns the Base64 decoded binary bytes.
Returns: The number of bytes written to the buffer.
Parameters:
  - buffer (System.Byte[]): The buffer into which to copy the resulting text. This value cannot be .
  - index (System.Int32): The offset into the buffer where to start copying the result.
  - count (System.Int32): The maximum number of bytes to copy into the buffer. The actual number of bytes copied is returned from this method.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsBase64" buffer index count))

(cl:defun read-content-as-base64-async (obj! buffer index count)
  "Summary: Asynchronously reads the content and returns the Base64 decoded binary bytes.
Returns: The number of bytes written to the buffer.
Parameters:
  - buffer (System.Byte[]): The buffer into which to copy the resulting text. This value cannot be .
  - index (System.Int32): The offset into the buffer where to start copying the result.
  - count (System.Int32): The maximum number of bytes to copy into the buffer. The actual number of bytes copied is returned from this method.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsBase64Async" buffer index count))

(cl:defun read-content-as-bin-hex (obj! buffer index count)
  "Summary: Reads the content and returns the decoded binary bytes.
Returns: The number of bytes written to the buffer.
Parameters:
  - buffer (System.Byte[]): The buffer into which to copy the resulting text. This value cannot be .
  - index (System.Int32): The offset into the buffer where to start copying the result.
  - count (System.Int32): The maximum number of bytes to copy into the buffer. The actual number of bytes copied is returned from this method.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsBinHex" buffer index count))

(cl:defun read-content-as-bin-hex-async (obj! buffer index count)
  "Summary: Asynchronously reads the content and returns the decoded binary bytes.
Returns: The number of bytes written to the buffer.
Parameters:
  - buffer (System.Byte[]): The buffer into which to copy the resulting text. This value cannot be .
  - index (System.Int32): The offset into the buffer where to start copying the result.
  - count (System.Int32): The maximum number of bytes to copy into the buffer. The actual number of bytes copied is returned from this method.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsBinHexAsync" buffer index count))

(cl:defun read-content-as-boolean (obj!)
  "Summary: Reads the text content at the current position as a .
Returns: The text content as a System.Boolean object.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsBoolean"))

(cl:defun read-content-as-date-time (obj!)
  "Summary: Reads the text content at the current position as a System.DateTime object.
Returns: The text content as a System.DateTime object.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsDateTime"))

(cl:defun read-content-as-date-time-offset (obj!)
  "Summary: Reads the text content at the current position as a System.DateTimeOffset object.
Returns: The text content as a System.DateTimeOffset object.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsDateTimeOffset"))

(cl:defun read-content-as-decimal (obj!)
  "Summary: Reads the text content at the current position as a System.Decimal object.
Returns: The text content at the current position as a System.Decimal object.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsDecimal"))

(cl:defun read-content-as-double (obj!)
  "Summary: Reads the text content at the current position as a double-precision floating-point number.
Returns: The text content as a double-precision floating-point number.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsDouble"))

(cl:defun read-content-as-float (obj!)
  "Summary: Reads the text content at the current position as a single-precision floating point number.
Returns: The text content at the current position as a single-precision floating point number.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsFloat"))

(cl:defun read-content-as-int (obj!)
  "Summary: Reads the text content at the current position as a 32-bit signed integer.
Returns: The text content as a 32-bit signed integer.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsInt"))

(cl:defun read-content-as-long (obj!)
  "Summary: Reads the text content at the current position as a 64-bit signed integer.
Returns: The text content as a 64-bit signed integer.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsLong"))

(cl:defun read-content-as-object (obj!)
  "Summary: Reads the text content at the current position as an System.Object.
Returns: The text content as the most appropriate common language runtime (CLR) object.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsObject"))

(cl:defun read-content-as-object-async (obj!)
  "Summary: Asynchronously reads the text content at the current position as an System.Object.
Returns: The text content as the most appropriate common language runtime (CLR) object.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsObjectAsync"))

(cl:defun read-content-as-string (obj!)
  "Summary: Reads the text content at the current position as a System.String object.
Returns: The text content as a System.String object.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsString"))

(cl:defun read-content-as-string-async (obj!)
  "Summary: Asynchronously reads the text content at the current position as a System.String object.
Returns: The text content as a System.String object.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadContentAsStringAsync"))

(cl:defun read-element-content-as (obj! return-type namespace-resolver cl:&optional (local-name cl:nil supplied-local-name) (namespace-uri cl:nil supplied-namespace-uri))
  "Master wrapper for System.Xml.XmlReader.ReadElementContentAs overloads. Dispatches at runtime.

ReadElementContentAs(Type, IXmlNamespaceResolver) -> Object
  Summary: Reads the element content as the requested type.
  Returns: The element content converted to the requested typed object.
  Parameters:
    - return-type (System.Type): The type of the value to be returned. Note With the release of the .NET Framework 3.5, the value of the returnType parameter can now be the System.DateTimeOffset type.
    - namespace-resolver (System.Xml.IXmlNamespaceResolver): An System.Xml.IXmlNamespaceResolver object that is used to resolve any namespace prefixes related to type conversion.

ReadElementContentAs(Type, IXmlNamespaceResolver, String, String) -> Object
  Summary: Checks that the specified local name and namespace URI matches that of the current element, then reads the element content as the requested type.
  Returns: The element content converted to the requested typed object.
  Parameters:
    - return-type (System.Type): The type of the value to be returned. Note With the release of the .NET Framework 3.5, the value of the returnType parameter can now be the System.DateTimeOffset type.
    - namespace-resolver (System.Xml.IXmlNamespaceResolver): An System.Xml.IXmlNamespaceResolver object that is used to resolve any namespace prefixes related to type conversion.
    - local-name (System.String): The local name of the element.
    - namespace-uri (System.String): The namespace URI of the element.
"
  (cl:cond
    ((cl:and (cl:or (cl:null return-type) (dotnet:is-instance-of return-type "System.Type")) (cl:or (cl:null namespace-resolver) (dotnet:is-instance-of namespace-resolver "System.Xml.IXmlNamespaceResolver")) supplied-local-name (cl:stringp local-name) supplied-namespace-uri (cl:stringp namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAs" return-type namespace-resolver local-name namespace-uri))
    ((cl:and (cl:or (cl:null return-type) (dotnet:is-instance-of return-type "System.Type")) (cl:or (cl:null namespace-resolver) (dotnet:is-instance-of namespace-resolver "System.Xml.IXmlNamespaceResolver")) (cl:not supplied-local-name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAs" return-type namespace-resolver))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadElementContentAs"
                    :supplied-args (cl:append (cl:list :return-type return-type) (cl:list :namespace-resolver namespace-resolver) (cl:when supplied-local-name (cl:list :local-name local-name)) (cl:when supplied-namespace-uri (cl:list :namespace-uri namespace-uri)))))))

(cl:defun read-element-content-as-async (obj! return-type namespace-resolver)
  "Summary: Asynchronously reads the element content as the requested type.
Returns: The element content converted to the requested typed object.
Parameters:
  - return-type (System.Type): The type of the value to be returned.
  - namespace-resolver (System.Xml.IXmlNamespaceResolver): An System.Xml.IXmlNamespaceResolver object that is used to resolve any namespace prefixes related to type conversion.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsAsync" return-type namespace-resolver))

(cl:defun read-element-content-as-base64 (obj! buffer index count)
  "Summary: Reads the element and decodes the content.
Returns: The number of bytes written to the buffer.
Parameters:
  - buffer (System.Byte[]): The buffer into which to copy the resulting text. This value cannot be .
  - index (System.Int32): The offset into the buffer where to start copying the result.
  - count (System.Int32): The maximum number of bytes to copy into the buffer. The actual number of bytes copied is returned from this method.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsBase64" buffer index count))

(cl:defun read-element-content-as-base64-async (obj! buffer index count)
  "Summary: Asynchronously reads the element and decodes the content.
Returns: The number of bytes written to the buffer.
Parameters:
  - buffer (System.Byte[]): The buffer into which to copy the resulting text. This value cannot be .
  - index (System.Int32): The offset into the buffer where to start copying the result.
  - count (System.Int32): The maximum number of bytes to copy into the buffer. The actual number of bytes copied is returned from this method.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsBase64Async" buffer index count))

(cl:defun read-element-content-as-bin-hex (obj! buffer index count)
  "Summary: Reads the element and decodes the content.
Returns: The number of bytes written to the buffer.
Parameters:
  - buffer (System.Byte[]): The buffer into which to copy the resulting text. This value cannot be .
  - index (System.Int32): The offset into the buffer where to start copying the result.
  - count (System.Int32): The maximum number of bytes to copy into the buffer. The actual number of bytes copied is returned from this method.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsBinHex" buffer index count))

(cl:defun read-element-content-as-bin-hex-async (obj! buffer index count)
  "Summary: Asynchronously reads the element and decodes the content.
Returns: The number of bytes written to the buffer.
Parameters:
  - buffer (System.Byte[]): The buffer into which to copy the resulting text. This value cannot be .
  - index (System.Int32): The offset into the buffer where to start copying the result.
  - count (System.Int32): The maximum number of bytes to copy into the buffer. The actual number of bytes copied is returned from this method.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsBinHexAsync" buffer index count))

(cl:defun read-element-content-as-boolean (obj! cl:&optional (local-name cl:nil supplied-local-name) (namespace-uri cl:nil supplied-namespace-uri))
  "Master wrapper for System.Xml.XmlReader.ReadElementContentAsBoolean overloads. Dispatches at runtime.

ReadElementContentAsBoolean() -> Boolean
  Summary: Reads the current element and returns the contents as a System.Boolean object.
  Returns: The element content as a System.Boolean object.

ReadElementContentAsBoolean(String, String) -> Boolean
  Summary: Checks that the specified local name and namespace URI matches that of the current element, then reads the current element and returns the contents as a System.Boolean object.
  Returns: The element content as a System.Boolean object.
  Parameters:
    - local-name (System.String): The local name of the element.
    - namespace-uri (System.String): The namespace URI of the element.
"
  (cl:cond
    ((cl:and supplied-local-name (cl:stringp local-name) supplied-namespace-uri (cl:stringp namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsBoolean" local-name namespace-uri))
    ((cl:and (cl:not supplied-local-name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsBoolean"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadElementContentAsBoolean"
                    :supplied-args (cl:append (cl:when supplied-local-name (cl:list :local-name local-name)) (cl:when supplied-namespace-uri (cl:list :namespace-uri namespace-uri)))))))

(cl:defun read-element-content-as-date-time (obj! cl:&optional (local-name cl:nil supplied-local-name) (namespace-uri cl:nil supplied-namespace-uri))
  "Master wrapper for System.Xml.XmlReader.ReadElementContentAsDateTime overloads. Dispatches at runtime.

ReadElementContentAsDateTime() -> DateTime
  Summary: Reads the current element and returns the contents as a System.DateTime object.
  Returns: The element content as a System.DateTime object.

ReadElementContentAsDateTime(String, String) -> DateTime
  Summary: Checks that the specified local name and namespace URI matches that of the current element, then reads the current element and returns the contents as a System.DateTime object.
  Returns: The element contents as a System.DateTime object.
  Parameters:
    - local-name (System.String): The local name of the element.
    - namespace-uri (System.String): The namespace URI of the element.
"
  (cl:cond
    ((cl:and supplied-local-name (cl:stringp local-name) supplied-namespace-uri (cl:stringp namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsDateTime" local-name namespace-uri))
    ((cl:and (cl:not supplied-local-name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsDateTime"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadElementContentAsDateTime"
                    :supplied-args (cl:append (cl:when supplied-local-name (cl:list :local-name local-name)) (cl:when supplied-namespace-uri (cl:list :namespace-uri namespace-uri)))))))

(cl:defun read-element-content-as-decimal (obj! cl:&optional (local-name cl:nil supplied-local-name) (namespace-uri cl:nil supplied-namespace-uri))
  "Master wrapper for System.Xml.XmlReader.ReadElementContentAsDecimal overloads. Dispatches at runtime.

ReadElementContentAsDecimal() -> Decimal
  Summary: Reads the current element and returns the contents as a System.Decimal object.
  Returns: The element content as a System.Decimal object.

ReadElementContentAsDecimal(String, String) -> Decimal
  Summary: Checks that the specified local name and namespace URI matches that of the current element, then reads the current element and returns the contents as a System.Decimal object.
  Returns: The element content as a System.Decimal object.
  Parameters:
    - local-name (System.String): The local name of the element.
    - namespace-uri (System.String): The namespace URI of the element.
"
  (cl:cond
    ((cl:and supplied-local-name (cl:stringp local-name) supplied-namespace-uri (cl:stringp namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsDecimal" local-name namespace-uri))
    ((cl:and (cl:not supplied-local-name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsDecimal"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadElementContentAsDecimal"
                    :supplied-args (cl:append (cl:when supplied-local-name (cl:list :local-name local-name)) (cl:when supplied-namespace-uri (cl:list :namespace-uri namespace-uri)))))))

(cl:defun read-element-content-as-double (obj! cl:&optional (local-name cl:nil supplied-local-name) (namespace-uri cl:nil supplied-namespace-uri))
  "Master wrapper for System.Xml.XmlReader.ReadElementContentAsDouble overloads. Dispatches at runtime.

ReadElementContentAsDouble() -> Double
  Summary: Reads the current element and returns the contents as a double-precision floating-point number.
  Returns: The element content as a double-precision floating-point number.

ReadElementContentAsDouble(String, String) -> Double
  Summary: Checks that the specified local name and namespace URI matches that of the current element, then reads the current element and returns the contents as a double-precision floating-point number.
  Returns: The element content as a double-precision floating-point number.
  Parameters:
    - local-name (System.String): The local name of the element.
    - namespace-uri (System.String): The namespace URI of the element.
"
  (cl:cond
    ((cl:and supplied-local-name (cl:stringp local-name) supplied-namespace-uri (cl:stringp namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsDouble" local-name namespace-uri))
    ((cl:and (cl:not supplied-local-name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsDouble"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadElementContentAsDouble"
                    :supplied-args (cl:append (cl:when supplied-local-name (cl:list :local-name local-name)) (cl:when supplied-namespace-uri (cl:list :namespace-uri namespace-uri)))))))

(cl:defun read-element-content-as-float (obj! cl:&optional (local-name cl:nil supplied-local-name) (namespace-uri cl:nil supplied-namespace-uri))
  "Master wrapper for System.Xml.XmlReader.ReadElementContentAsFloat overloads. Dispatches at runtime.

ReadElementContentAsFloat() -> Single
  Summary: Reads the current element and returns the contents as single-precision floating-point number.
  Returns: The element content as a single-precision floating point number.

ReadElementContentAsFloat(String, String) -> Single
  Summary: Checks that the specified local name and namespace URI matches that of the current element, then reads the current element and returns the contents as a single-precision floating-point number.
  Returns: The element content as a single-precision floating point number.
  Parameters:
    - local-name (System.String): The local name of the element.
    - namespace-uri (System.String): The namespace URI of the element.
"
  (cl:cond
    ((cl:and supplied-local-name (cl:stringp local-name) supplied-namespace-uri (cl:stringp namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsFloat" local-name namespace-uri))
    ((cl:and (cl:not supplied-local-name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsFloat"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadElementContentAsFloat"
                    :supplied-args (cl:append (cl:when supplied-local-name (cl:list :local-name local-name)) (cl:when supplied-namespace-uri (cl:list :namespace-uri namespace-uri)))))))

(cl:defun read-element-content-as-int (obj! cl:&optional (local-name cl:nil supplied-local-name) (namespace-uri cl:nil supplied-namespace-uri))
  "Master wrapper for System.Xml.XmlReader.ReadElementContentAsInt overloads. Dispatches at runtime.

ReadElementContentAsInt() -> Int32
  Summary: Reads the current element and returns the contents as a 32-bit signed integer.
  Returns: The element content as a 32-bit signed integer.

ReadElementContentAsInt(String, String) -> Int32
  Summary: Checks that the specified local name and namespace URI matches that of the current element, then reads the current element and returns the contents as a 32-bit signed integer.
  Returns: The element content as a 32-bit signed integer.
  Parameters:
    - local-name (System.String): The local name of the element.
    - namespace-uri (System.String): The namespace URI of the element.
"
  (cl:cond
    ((cl:and supplied-local-name (cl:stringp local-name) supplied-namespace-uri (cl:stringp namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsInt" local-name namespace-uri))
    ((cl:and (cl:not supplied-local-name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsInt"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadElementContentAsInt"
                    :supplied-args (cl:append (cl:when supplied-local-name (cl:list :local-name local-name)) (cl:when supplied-namespace-uri (cl:list :namespace-uri namespace-uri)))))))

(cl:defun read-element-content-as-long (obj! cl:&optional (local-name cl:nil supplied-local-name) (namespace-uri cl:nil supplied-namespace-uri))
  "Master wrapper for System.Xml.XmlReader.ReadElementContentAsLong overloads. Dispatches at runtime.

ReadElementContentAsLong() -> Int64
  Summary: Reads the current element and returns the contents as a 64-bit signed integer.
  Returns: The element content as a 64-bit signed integer.

ReadElementContentAsLong(String, String) -> Int64
  Summary: Checks that the specified local name and namespace URI matches that of the current element, then reads the current element and returns the contents as a 64-bit signed integer.
  Returns: The element content as a 64-bit signed integer.
  Parameters:
    - local-name (System.String): The local name of the element.
    - namespace-uri (System.String): The namespace URI of the element.
"
  (cl:cond
    ((cl:and supplied-local-name (cl:stringp local-name) supplied-namespace-uri (cl:stringp namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsLong" local-name namespace-uri))
    ((cl:and (cl:not supplied-local-name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsLong"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadElementContentAsLong"
                    :supplied-args (cl:append (cl:when supplied-local-name (cl:list :local-name local-name)) (cl:when supplied-namespace-uri (cl:list :namespace-uri namespace-uri)))))))

(cl:defun read-element-content-as-object (obj! cl:&optional (local-name cl:nil supplied-local-name) (namespace-uri cl:nil supplied-namespace-uri))
  "Master wrapper for System.Xml.XmlReader.ReadElementContentAsObject overloads. Dispatches at runtime.

ReadElementContentAsObject() -> Object
  Summary: Reads the current element and returns the contents as an System.Object.
  Returns: A boxed common language runtime (CLR) object of the most appropriate type. The System.Xml.XmlReader.ValueType property determines the appropriate CLR type. If the content is typed as a list type, this method returns an array of boxed objects of the appropriate type.

ReadElementContentAsObject(String, String) -> Object
  Summary: Checks that the specified local name and namespace URI matches that of the current element, then reads the current element and returns the contents as an System.Object.
  Returns: A boxed common language runtime (CLR) object of the most appropriate type. The System.Xml.XmlReader.ValueType property determines the appropriate CLR type. If the content is typed as a list type, this method returns an array of boxed objects of the appropriate type.
  Parameters:
    - local-name (System.String): The local name of the element.
    - namespace-uri (System.String): The namespace URI of the element.
"
  (cl:cond
    ((cl:and supplied-local-name (cl:stringp local-name) supplied-namespace-uri (cl:stringp namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsObject" local-name namespace-uri))
    ((cl:and (cl:not supplied-local-name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsObject"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadElementContentAsObject"
                    :supplied-args (cl:append (cl:when supplied-local-name (cl:list :local-name local-name)) (cl:when supplied-namespace-uri (cl:list :namespace-uri namespace-uri)))))))

(cl:defun read-element-content-as-object-async (obj!)
  "Summary: Asynchronously reads the current element and returns the contents as an System.Object.
Returns: A boxed common language runtime (CLR) object of the most appropriate type. The System.Xml.XmlReader.ValueType property determines the appropriate CLR type. If the content is typed as a list type, this method returns an array of boxed objects of the appropriate type.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsObjectAsync"))

(cl:defun read-element-content-as-string (obj! cl:&optional (local-name cl:nil supplied-local-name) (namespace-uri cl:nil supplied-namespace-uri))
  "Master wrapper for System.Xml.XmlReader.ReadElementContentAsString overloads. Dispatches at runtime.

ReadElementContentAsString() -> String
  Summary: Reads the current element and returns the contents as a System.String object.
  Returns: The element content as a System.String object.

ReadElementContentAsString(String, String) -> String
  Summary: Checks that the specified local name and namespace URI matches that of the current element, then reads the current element and returns the contents as a System.String object.
  Returns: The element content as a System.String object.
  Parameters:
    - local-name (System.String): The local name of the element.
    - namespace-uri (System.String): The namespace URI of the element.
"
  (cl:cond
    ((cl:and supplied-local-name (cl:stringp local-name) supplied-namespace-uri (cl:stringp namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsString" local-name namespace-uri))
    ((cl:and (cl:not supplied-local-name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsString"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadElementContentAsString"
                    :supplied-args (cl:append (cl:when supplied-local-name (cl:list :local-name local-name)) (cl:when supplied-namespace-uri (cl:list :namespace-uri namespace-uri)))))))

(cl:defun read-element-content-as-string-async (obj!)
  "Summary: Asynchronously reads the current element and returns the contents as a System.String object.
Returns: The element content as a System.String object.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementContentAsStringAsync"))

(cl:defun read-element-string (obj! cl:&optional (name cl:nil supplied-name) (ns cl:nil supplied-ns))
  "Master wrapper for System.Xml.XmlReader.ReadElementString overloads. Dispatches at runtime.

ReadElementString() -> String
  Summary: Reads a text-only element. However, we recommend that you use the System.Xml.XmlReader.ReadElementContentAsString method instead, because it provides a more straightforward way to handle this operation.
  Returns: The text contained in the element that was read. An empty string if the element is empty.

ReadElementString(String) -> String
  Summary: Checks that the System.Xml.XmlReader.Name property of the element found matches the given string before reading a text-only element. However, we recommend that you use the System.Xml.XmlReader.ReadElementContentAsString method instead, because it provides a more straightforward way to handle this operation.
  Returns: The text contained in the element that was read. An empty string if the element is empty.
  Parameters:
    - name (System.String): The name to check.

ReadElementString(String, String) -> String
  Summary: Checks that the System.Xml.XmlReader.LocalName and System.Xml.XmlReader.NamespaceURI properties of the element found matches the given strings before reading a text-only element. However, we recommend that you use the System.Xml.XmlReader.ReadElementContentAsString(System.String,System.String) method instead, because it provides a more straightforward way to handle this operation.
  Returns: The text contained in the element that was read. An empty string if the element is empty.
  Parameters:
    - localname (System.String): The local name to check.
    - ns (System.String): The namespace URI to check.
"
  (cl:cond
    ((cl:and supplied-name (cl:stringp name) supplied-ns (cl:stringp ns))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementString" name ns))
    ((cl:and supplied-name (cl:stringp name) (cl:not supplied-ns))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementString" name))
    ((cl:and (cl:not supplied-name) (cl:not supplied-ns))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadElementString"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadElementString"
                    :supplied-args (cl:append (cl:when supplied-name (cl:list :name name)) (cl:when supplied-ns (cl:list :ns ns)))))))

(cl:defun read-end-element (obj!)
  "Summary: Checks that the current content node is an end tag and advances the reader to the next node.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadEndElement"))

(cl:defun read-inner-xml (obj!)
  "Summary: When overridden in a derived class, reads all the content, including markup, as a string.
Returns: All the XML content, including markup, in the current node. If the current node has no children, an empty string is returned. If the current node is neither an element nor attribute, an empty string is returned.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadInnerXml"))

(cl:defun read-inner-xml-async (obj!)
  "Summary: Asynchronously reads all the content, including markup, as a string.
Returns: All the XML content, including markup, in the current node. If the current node has no children, an empty string is returned.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadInnerXmlAsync"))

(cl:defun read-outer-xml (obj!)
  "Summary: When overridden in a derived class, reads the content, including markup, representing this node and all its children.
Returns: If the reader is positioned on an element or an attribute node, this method returns all the XML content, including markup, of the current node and all its children; otherwise, it returns an empty string.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadOuterXml"))

(cl:defun read-outer-xml-async (obj!)
  "Summary: Asynchronously reads the content, including markup, representing this node and all its children.
Returns: If the reader is positioned on an element or an attribute node, this method returns all the XML content, including markup, of the current node and all its children; otherwise, it returns an empty string.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadOuterXmlAsync"))

(cl:defun read-start-element (obj! cl:&optional (name cl:nil supplied-name) (ns cl:nil supplied-ns))
  "Master wrapper for System.Xml.XmlReader.ReadStartElement overloads. Dispatches at runtime.

ReadStartElement() -> Void
  Summary: Checks that the current node is an element and advances the reader to the next node.

ReadStartElement(String) -> Void
  Summary: Checks that the current content node is an element with the given System.Xml.XmlReader.Name and advances the reader to the next node.
  Parameters:
    - name (System.String): The qualified name of the element.

ReadStartElement(String, String) -> Void
  Summary: Checks that the current content node is an element with the given System.Xml.XmlReader.LocalName and System.Xml.XmlReader.NamespaceURI and advances the reader to the next node.
  Parameters:
    - localname (System.String): The local name of the element.
    - ns (System.String): The namespace URI of the element.
"
  (cl:cond
    ((cl:and supplied-name (cl:stringp name) supplied-ns (cl:stringp ns))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadStartElement" name ns))
    ((cl:and supplied-name (cl:stringp name) (cl:not supplied-ns))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadStartElement" name))
    ((cl:and (cl:not supplied-name) (cl:not supplied-ns))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadStartElement"))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadStartElement"
                    :supplied-args (cl:append (cl:when supplied-name (cl:list :name name)) (cl:when supplied-ns (cl:list :ns ns)))))))

(cl:defun read-string (obj!)
  "Summary: When overridden in a derived class, reads the contents of an element or text node as a string. However, we recommend that you use the System.Xml.XmlReader.ReadElementContentAsString method instead, because it provides a more straightforward way to handle this operation.
Returns: The contents of the element or an empty string.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadString"))

(cl:defun read-subtree (obj!)
  "Summary: Returns a new instance that can be used to read the current node, and all its descendants.
Returns: A new XML reader instance set to System.Xml.ReadState.Initial. Calling the System.Xml.XmlReader.Read method positions the new reader on the node that was current before the call to the System.Xml.XmlReader.ReadSubtree method.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadSubtree"))

(cl:defun read-to-descendant (obj! name cl:&optional (namespace-uri cl:nil supplied-namespace-uri))
  "Master wrapper for System.Xml.XmlReader.ReadToDescendant overloads. Dispatches at runtime.

ReadToDescendant(String) -> Boolean
  Summary: Advances the System.Xml.XmlReader to the next descendant element with the specified qualified name.
  Returns: if a matching descendant element is found; otherwise . If a matching descendant element is not found, the System.Xml.XmlReader is positioned on the end tag (System.Xml.XmlReader.NodeType is ) of the element. If the System.Xml.XmlReader is not positioned on an element when System.Xml.XmlReader.ReadToDescendant(System.String) was called, this method returns and the position of the System.Xml.XmlReader is not changed.
  Parameters:
    - name (System.String): The qualified name of the element you wish to move to.

ReadToDescendant(String, String) -> Boolean
  Summary: Advances the System.Xml.XmlReader to the next descendant element with the specified local name and namespace URI.
  Returns: if a matching descendant element is found; otherwise . If a matching descendant element is not found, the System.Xml.XmlReader is positioned on the end tag (System.Xml.XmlReader.NodeType is ) of the element. If the System.Xml.XmlReader is not positioned on an element when System.Xml.XmlReader.ReadToDescendant(System.String,System.String) was called, this method returns and the position of the System.Xml.XmlReader is not changed.
  Parameters:
    - local-name (System.String): The local name of the element you wish to move to.
    - namespace-uri (System.String): The namespace URI of the element you wish to move to.
"
  (cl:cond
    ((cl:and (cl:stringp name) supplied-namespace-uri (cl:stringp namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadToDescendant" name namespace-uri))
    ((cl:and (cl:stringp name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadToDescendant" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadToDescendant"
                    :supplied-args (cl:append (cl:list :name name) (cl:when supplied-namespace-uri (cl:list :namespace-uri namespace-uri)))))))

(cl:defun read-to-following (obj! name cl:&optional (namespace-uri cl:nil supplied-namespace-uri))
  "Master wrapper for System.Xml.XmlReader.ReadToFollowing overloads. Dispatches at runtime.

ReadToFollowing(String) -> Boolean
  Summary: Reads until an element with the specified qualified name is found.
  Returns: if a matching element is found; otherwise and the System.Xml.XmlReader is in an end of file state.
  Parameters:
    - name (System.String): The qualified name of the element.

ReadToFollowing(String, String) -> Boolean
  Summary: Reads until an element with the specified local name and namespace URI is found.
  Returns: if a matching element is found; otherwise and the System.Xml.XmlReader is in an end of file state.
  Parameters:
    - local-name (System.String): The local name of the element.
    - namespace-uri (System.String): The namespace URI of the element.
"
  (cl:cond
    ((cl:and (cl:stringp name) supplied-namespace-uri (cl:stringp namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadToFollowing" name namespace-uri))
    ((cl:and (cl:stringp name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadToFollowing" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadToFollowing"
                    :supplied-args (cl:append (cl:list :name name) (cl:when supplied-namespace-uri (cl:list :namespace-uri namespace-uri)))))))

(cl:defun read-to-next-sibling (obj! name cl:&optional (namespace-uri cl:nil supplied-namespace-uri))
  "Master wrapper for System.Xml.XmlReader.ReadToNextSibling overloads. Dispatches at runtime.

ReadToNextSibling(String) -> Boolean
  Summary: Advances the to the next sibling element with the specified qualified name.
  Returns: if a matching sibling element is found; otherwise . If a matching sibling element is not found, the is positioned on the end tag (System.Xml.XmlReader.NodeType is ) of the parent element.
  Parameters:
    - name (System.String): The qualified name of the sibling element you wish to move to.

ReadToNextSibling(String, String) -> Boolean
  Summary: Advances the to the next sibling element with the specified local name and namespace URI.
  Returns: if a matching sibling element is found; otherwise, . If a matching sibling element is not found, the is positioned on the end tag (System.Xml.XmlReader.NodeType is ) of the parent element.
  Parameters:
    - local-name (System.String): The local name of the sibling element you wish to move to.
    - namespace-uri (System.String): The namespace URI of the sibling element you wish to move to.
"
  (cl:cond
    ((cl:and (cl:stringp name) supplied-namespace-uri (cl:stringp namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadToNextSibling" name namespace-uri))
    ((cl:and (cl:stringp name) (cl:not supplied-namespace-uri))
     (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadToNextSibling" name))
    (cl:t (cl:error 'csharp-assembly-utils:csharp-overload-not-found
                    :package-name "SYSTEM-XML-XML-READER"
                    :class-name <type-str>
                    :method-name "ReadToNextSibling"
                    :supplied-args (cl:append (cl:list :name name) (cl:when supplied-namespace-uri (cl:list :namespace-uri namespace-uri)))))))

(cl:defun read-value-chunk (obj! buffer index count)
  "Summary: Reads large streams of text embedded in an XML document.
Returns: The number of characters read into the buffer. The value zero is returned when there is no more text content.
Parameters:
  - buffer (System.Char[]): The array of characters that serves as the buffer to which the text contents are written. This value cannot be .
  - index (System.Int32): The offset within the buffer where the System.Xml.XmlReader can start to copy the results.
  - count (System.Int32): The maximum number of characters to copy into the buffer. The actual number of characters copied is returned from this method.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadValueChunk" buffer index count))

(cl:defun read-value-chunk-async (obj! buffer index count)
  "Summary: Asynchronously reads large streams of text embedded in an XML document.
Returns: The number of characters read into the buffer. The value zero is returned when there is no more text content.
Parameters:
  - buffer (System.Char[]): The array of characters that serves as the buffer to which the text contents are written. This value cannot be .
  - index (System.Int32): The offset within the buffer where the System.Xml.XmlReader can start to copy the results.
  - count (System.Int32): The maximum number of characters to copy into the buffer. The actual number of characters copied is returned from this method.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ReadValueChunkAsync" buffer index count))

(cl:defun resolve-entity (obj!)
  "Summary: When overridden in a derived class, resolves the entity reference for nodes.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "ResolveEntity"))

(cl:defun skip (obj!)
  "Summary: Skips the children of the current node.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "Skip"))

(cl:defun skip-async (obj!)
  "Summary: Asynchronously skips the children of the current node.
Returns: The current node.
"
  (dotnet:invoke (cl:the (dotnet "System.Xml.XmlReader") obj!) "SkipAsync"))

