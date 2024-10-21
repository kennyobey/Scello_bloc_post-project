import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/post_bloc.dart';
import '../blocs/post_event.dart';
import '../blocs/post_state.dart';


class EditPostScreen extends StatefulWidget {
  final int postId;
  final String initialTitle;
  final String initialBody;

  const EditPostScreen({
    super.key,
    required this.postId,
    required this.initialTitle,
    required this.initialBody,
  });

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String body;

  @override
  void initState() {
    super.initState();
    title = widget.initialTitle; 
    body = widget.initialBody; 
  }

  void _onSavePressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      BlocProvider.of<PostBloc>(context).add(
        UpdatePostEvent(
          widget.postId, 
          title,
          body,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostEditSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Post updated successfully!')),
            );
            Navigator.pop(context); 
          } else if (state is PostErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Edit Post',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: 'Title',
                    initialValue: title,
                    onSaved: (value) => title = value!,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a title' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: 'Body',
                    maxLines: 5,
                    initialValue: body,
                    onSaved: (value) => body = value!,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter the body' : null,
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      final isEditing =
                          state is PostEditingState; 
                      return Center(
                        child: ElevatedButton.icon(
                          onPressed: isEditing
                              ? null
                              : _onSavePressed, 
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 40),
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          icon: const Icon(Icons.save, color: Colors.white),
                          label: const Text(
                            'Save Changes',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  if (BlocProvider.of<PostBloc>(context).state
                      is PostEditingState)
                    const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    String? initialValue,
    int? maxLines,
  }) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
