#!/usr/bin/env sh
# Сборка: полный конспект build/notes.pdf и по PDF на каждую лекцию в build/lectures/.
set -eu
cd "$(dirname "$0")"
mkdir -p build/lectures
typst compile main.typ build/notes.pdf
for f in lectures/*.typ; do
  out="build/${f%.typ}.pdf"
  typst compile lecture.typ "$out" --input "lec=$f"
done
