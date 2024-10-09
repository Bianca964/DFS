
# TASK 3 - DFS
        Acest task realizeaza implementarea recursiva a algoritmului DFS
    (depth-first search) pentru explorarea unui graf. Incepe prin a salva
    toti registrii pentru a-i restaura la final, dupa care preia de pe stiva
    nodul sursa si functia `expand` ce ii returneaza lista de vecini. Urmeaza
    pasii urmatori :
        ~ verifica daca nodul sursa a fost deja vizitat, daca a fost sarind
    la finalul functiei
        ~ daca nodul nu a fost vizitat, il marcheaza ca vizitat si il afiseaza
    (salvand valoarea actuala pentru 'eax' intrucat apeleaza functia printf)
        ~ retine structura ce contine vectorul de vecini si numarul acestora
    apeland functia data ca parametru si verifica daca intoarce un rezultat
    null, caz in care sare la finalul functiei
        ~ preia numarul vecinilor si vectorul de vecini, verificand, depotriva,
    daca vreunul dintre ei este null, dupa care incepe parcurgerea tuturor
    vecinilor 
        ~ apeleaza recursiv functia pe vecinul curent (salveaza in prealabil
    registrii si ii restaureaza dupa apelul recursiv pentru a ramane
    neschimbati).
        ~ contorul 'ecx' ese incrementat, iar bucla se repeta pana cand toti
    vecinii au fost procesati
