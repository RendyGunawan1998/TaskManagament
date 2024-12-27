import 'package:flutter/services.dart';
import 'package:taskmanagement/core.dart';

hbox(double h) {
  return SizedBox(
    height: h,
  );
}

wbox(double w) {
  return SizedBox(
    width: w,
  );
}

tffPass(TextEditingController controller, String hint, bool visible,
    VoidCallback func) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey, width: 1),
    ),
    child: TextFormField(
      controller: controller,
      obscureText: !visible,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          prefixIcon: Icon(Icons.lock_outline, color: Colors.black54),
          suffixIcon: InkWell(
              onTap: func,
              child: Icon(visible ? Icons.visibility : Icons.visibility_off))),
    ),
  );
}

tffIcon(TextEditingController controller, String hint, IconData icon) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey, width: 1),
    ),
    child: TextFormField(
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        prefixIcon: Icon(icon, color: Colors.black54),
      ),
    ),
  );
}

tffIconPress(TextEditingController controller, String hint, IconData icon,
    Function() func, Function(String)? onChanged) {
  return Padding(
    padding: EdgeInsets.all(6),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          prefixIcon:
              InkWell(onTap: func, child: Icon(icon, color: Colors.black54)),
        ),
        onChanged: onChanged,
      ),
    ),
  );
}

tff(TextEditingController controller, String hint) {
  return Container(
    padding: EdgeInsets.fromLTRB(15, 2, 15, 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey, width: 1),
    ),
    child: TextFormField(
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
      ),
    ),
  );
}

tffDate(TextEditingController controller, String hint, Function() func) {
  return Container(
    padding: EdgeInsets.fromLTRB(15, 2, 15, 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey, width: 1),
    ),
    child: TextFormField(
      controller: controller,
      readOnly: true,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: InkWell(onTap: func, child: Icon(Icons.date_range)),
        border: InputBorder.none,
      ),
    ),
  );
}

tffTitle(TextEditingController controller, String hint) {
  return Container(
    padding: EdgeInsets.fromLTRB(15, 2, 15, 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey, width: 1),
    ),
    child: TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
      ),
    ),
  );
}

imageLogo() {
  return Image.asset(
    AssetsHelper.imgLogo,
    width: 150,
    fit: BoxFit.cover,
  );
}

textButton(String text, Function() func) {
  return TextButton(
    onPressed: func,
    child: Text(text),
  );
}

buttonBlue(String text, Function() func) {
  return InkWell(
    onTap: func,
    child: Container(
        width: Get.width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
        ))),
  );
}

ddStatus(String? selectedStatus, List<DropdownMenuItem<String>>? items,
    Function(String?)? func) {
  return Container(
    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey, width: 1),
    ),
    child: DropdownButtonFormField<String>(
      value: selectedStatus,
      decoration: InputDecoration(
        hintText: "Pilih Status",
        border: InputBorder.none,
      ),
      items: items,
      onChanged: func,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Pilih Status agar tidak kosong";
        }
        return null;
      },
    ),
  );
}

void showFilterDialog(
    BuildContext context, String filterStatus, Function(String?)? onChanged) {
  final List<String> statuses = ['All', 'Pending', 'In Progress', 'Completed'];
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Filter by Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: statuses.map((status) {
            return RadioListTile<String>(
              title: Text(status),
              value: status,
              groupValue: filterStatus,
              onChanged: onChanged,
            );
          }).toList(),
        ),
      );
    },
  );
}

appBarTask(
  BuildContext context,
  bool changeTheme,
  Function() funcFilter,
  Function() funcTheme,
) {
  return AppBar(
    backgroundColor: Colors.blue[200],
    title: Text(
      'List Task',
      style: TextStyle(color: Colors.black),
    ),
    actions: [
      IconButton(
        icon: const Icon(
          Icons.filter_list,
          color: Colors.black,
        ),
        onPressed: funcFilter,
      ),
      InkWell(
        onTap: funcTheme,
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(changeTheme ? Icons.nights_stay : Icons.wb_sunny,
              color: Colors.white),
        ),
      ),
    ],
  );
}

textChangeColor(String title, bool changeTheme) {
  return Text(
    title,
    style: TextStyle(color: changeTheme ? Colors.black : Colors.black87),
  );
}

textChangeColor2(String title, bool changeTheme) {
  return Text(
    title,
    maxLines: 2,
    style: TextStyle(color: changeTheme ? Colors.black : Colors.black87),
  );
}
