%include "../include/io.mac"

; The `expand` function returns an address to the following type of data
; structure.
struc neighbours_t
    .num_neighs resd 1  ; The number of neighbours returned.
    .neighs resd 1      ; Address of the vector containing the `num_neighs` neighbours.
                        ; A neighbour is represented by an unsigned int (dword).
endstruc

section .bss
; Vector for keeping track of visited nodes.
visited resd 10000
global visited

section .data
; Format string for printf.
fmt_str db "%u", 10, 0

section .text
global dfs
extern printf

; C function signiture:
;   void dfs(uint32_t node, neighbours_t *(*expand)(uint32_t node))
; where:
; - node -> the id of the source node for dfs.
; - expand -> pointer to a function that takes a node id and returns a structure
; populated with the neighbours of the node (see struc neighbours_t above).
; 
; note: uint32_t is an unsigned int, stored on 4 bytes (dword).
dfs:
    push ebp
    mov ebp, esp

    ; TODO: Implement the depth first search algorith, using the `expand`
    ; function to get the neighbours. When a node is visited, print it by
    ; calling `printf` with the format string in section .data.

    ; save preserved registers
    pusha

    ; eax = node
    mov eax, [ebp + 8]
    ; ebx = expand function
    mov ebx, [ebp + 12]

    ; check if the node is already visited
    mov ecx, visited
    ; go to corresponding index for the current node in visited array
    cmp dword [ecx + 4 * eax], 1
    je done

    ; mark the node as visited
    mov dword [ecx + 4 * eax], 1

print_node:
    ; save node before calling printf
    push eax

    ; push node as argument and format string for the printf function
    push eax
    push fmt_str
    call printf
    ; clean up stack (2 arguments for printf function call)
    add esp, 8

    ; restore node after calling printf
    pop eax

call_expand_function_to_get_neighbours:
    ; push node on stack as argument for expand function
    push eax
    call ebx
    ; clean up stack (1 argument for expand function call)
    add esp, 4

    ; eax is now the address of the neighbours_t structure (check if it's null)
    test eax, eax
    jz done

load_neighbours_structure:
    ; edi = num_neigh
    mov edi, [eax]
    test edi, edi
    jz done
    ; esi = address of neighbours vector
    mov esi, [eax + 4]
    test esi, esi
    jz done

    ; loop through each neighbour (ecx = contor initialised with 0)
    xor ecx, ecx

neigh_loop:
    ; if ecx >= edi, exit loop
    cmp ecx, edi
    jge done

    ; load neighbour node in edx (multiplied by 4 because the size of the data
    ; contained by the vector is unsigned int, meaning 4)
    mov edx, [esi + 4 * ecx]

    ; preserve registers altered in dfs function call
    push edx
    push esi
    push edi

    ; push expand function
    push ebx
    ; push current node
    push edx
    call dfs
    ; clean up stack (2 arguments)
    add esp, 8

    ; restore preserved registers
    pop edi
    pop esi
    pop edx

    inc ecx
    jmp neigh_loop

done:
    popa

    leave
    ret
