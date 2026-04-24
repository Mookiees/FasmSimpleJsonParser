# JSON Parser на FASM

Простой JSON‑парсер, написанный на ассемблере FASM (Flat Assembler) для Windows. Позволяет извлекать строковые и числовые значения из JSON‑строк.

## Особенности

* Работа с числовыми значениями (целые числа).
* Извлечение строковых значений.
* Минимальные зависимости — использует только функции Windows API.
* Консольное приложение для Windows (формат PE GUI).

## Требования

* [FASM (Flat Assembler)](https://flatassembler.net/) — компилятор ассемблера.
* Операционная система Windows (XP и выше).
* Базовые знания ассемблера x86 и работы с Windows API.

## Сборка проекта

1. Установите FASM.
2. Поместите все файлы проекта в одну директорию.
3. Откройте командную строку и перейдите в директорию проекта.
4. Выполните команду для компиляции:

   ```bash
   fasm FasmSimpleJsonParser.asm
В результате будет создан исполняемый файл your_project_name.exe.

## Вклад в проект
Если вы хотите улучшить парсер (добавить поддержку вложенных объектов, массивов и т. д.), создайте Pull Request или откройте Issue с описанием идеи.
## ПРИМЕР
* Пример получения BOOL значения из JSON обьекта
 ```asm
      ;        test_data          db         '{"vlad": true,   "desoq":false}', 0
      ;        key1               db         'vlad', 0
      ;        key2               db         "desoq", 0  
      push     key1
      push     test_data
      call     get_bool_el
      cmp      byte[eax], 74
      ; EAX is true (74=t)

      push     key2
      push     test_data
      call     get_bool_el
      cmp      byte[eax], 66
      ; EAX is false (66=f)
