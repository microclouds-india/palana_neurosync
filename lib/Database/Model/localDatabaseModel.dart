class LocalDatabseModel {
         int id;
         String value;

        LocalDatabseModel({required this.id, required this.value});

        factory LocalDatabseModel.fromJson(Map<String, dynamic> parsedJson){
            return LocalDatabseModel(
                id : parsedJson['id'],
                value : parsedJson['z']
            );
        }
        }
