//
//  Alo.cpp
//  PROJECT
//
//  Created by Мак on 21.05.2023.
//  Copyright © 2023 Мак. All rights reserved.
//

#include "Alo.hpp"

#include <iostream>

using namespace std;

struct Node {
    float d;
    Node *next;
};

Node* create_list(float d);
void add(Node **pend, float d);
void print_list(Node *pbeg);
void delete_list(Node *pbeg);

int main() {
    float i, i1;
    Node *pbeg = nullptr; // первый элемент первого списка
    Node *pend = nullptr; // последний элемент первого списка
    cout << "Введите элементы первого списка (введите 0, чтобы остановить ввод):\n";
    while (cin >> i && i != 0) {
        add(&pend, i);
        if (pbeg == nullptr) {
            pbeg = pend; // устанавливаем первый элемент списка
        }
    }
    
    Node *pbeg1 = nullptr; // первый элемент второго списка
    Node *pend1 = nullptr; // последний элемент второго списка
    cout << "Введите элементы второго списка (введите 0, чтобы остановить ввод):\n";
    while (cin >> i1 && i1 != 0) {
        add(&pend1, i1);
        if (pbeg1 == nullptr) {
            pbeg1 = pend1; // устанавливаем первый элемент списка
        }
    }
    
    // Складываем элементы списков
    float sum = 0;
    Node *p = pbeg;
    while (p) {
        sum += p->d;
        p = p->next;
    }
    p = pbeg1;
    while (p) {
        sum += p->d;
        p = p->next;
    }
    
    cout << "Сумма элементов двух списков: " << sum << endl;
    
    // Освобождаем память
    delete_list(pbeg);
    delete_list(pbeg1);
    
    return 0;
}

// Создание списка с одним элементом
Node* create_list(float d) {
    Node *pv = new Node;
    pv->d = d;
    pv->next = nullptr;
    return pv;
}

// Добавление элемента в конец списка
void add(Node **pend, float d) {
    Node *pv = new Node;
    pv->d = d;
    pv->next = nullptr;
    if (*pend == nullptr) {
        *pend = create_list(d);
    } else {
        (*pend)->next = pv;
        *pend = pv;
    }
}

// Печать списка
void print_list(Node *pbeg) {
    Node *p = pbeg;
    while (p) {
        cout << p->d << " ";
        p = p->next;
    }
    cout << endl;
}

// Освобождение памяти, занятой списком
void delete_list(Node *pbeg) {
    Node *p = pbeg;
    while (p) {
        Node *tmp = p->next;
        delete p;
        p = tmp;
    }
}
