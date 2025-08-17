(module
  ;; import input and output buffer
  (import "env" "inputMemory" (memory $input 1))
  (import "env" "outputMemory" (memory $output 1))

  (func (export "cumsum") (param $len i32)
    ;; declare local (auto init 0)
    (local $idx i32)
    (local $sum f32)

    ;; iterate over all element of input
    ;; and write cumsum to output
    (loop $iter
      ;; $sum += input[$idx * 4]
      local.get $idx
      i32.const 4
      i32.mul
      f32.load $input
      local.get $sum
      f32.add
      local.set $sum

      ;; output[$idx * 4] = $sum
      local.get $idx
      i32.const 4
      i32.mul
      local.get $sum
      f32.store $output

      ;; $idx += 1
      local.get $idx
      i32.const 1
      i32.add
      local.set $idx

      ;; if $idx < $len
      ;;   then continue loop
      local.get $idx
      local.get $len
      i32.lt_u
      br_if $iter
    )
  )
)
