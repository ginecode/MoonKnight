# mkdir lib/dart
# mkdir lib/py
# mkdir lib/ts

# protoc.exe --dart_out=../lib/snap/models/ lib/*.proto  google/protobuf/timestamp.proto
# cmd.exe /c '.\node_modules\.bin\grpc_tools_node_protoc --js_out=import_style=commonjs,binary:..\functions\lib\ --ts_out=..\functions\src\ lib\*.proto'
# cmd.exe /c python -m grpc_tools.protoc --proto_path=. --python_out=lib/py --grpc_python_out=lib/py lib/*.proto
