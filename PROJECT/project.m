#import <Foundation/Foundation.h>

@interface Node : NSObject
@property (nonatomic, assign) float d;
@property (nonatomic, strong) Node *next;
@property (nonatomic, strong) Node *prev;
@end

@implementation Node
@end

Node *first(float d) {
    Node *pv = [[Node alloc] init];
    pv.d = d;
    pv.next = nil;
    pv.prev = nil;
    return pv;
}

void add(Node **pend, float d) {
    Node *pv = [[Node alloc] init];
    pv.d = d;
    pv.next = nil;
    pv.prev = *pend;
    (*pend).next = pv;
    *pend = pv;
}

Node *find(Node *const pbeg, float i) {
    Node *pv = pbeg;
    while (pv) {
        if (pv.d == i) break;
        pv = pv.next;
    }
    return pv;
}

Node *insert(Node *const pbeg, Node **pend, float key, float d) {
    if (Node *pkey = find(pbeg, key)) {
        Node *pv = [[Node alloc] init];
        pv.d = d;
        pv.next = pkey.next;
        pv.prev = pkey;
        pkey.next = pv;
        if (pkey != *pend)
            (pv.next).prev = pv;
        else
            *pend = pv;
        return pv;
    }
    return nil;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Node *alist = nil; // список a
        Node *blist = nil; // список b
        Node *apend = nil; // указатель на последний элемент списка a
        Node *bpend = nil; // указатель на последний элемент списка b
        float d;
        
        // ввод списка a
        printf("Введите элементы списка a (0 - конец ввода):\\n");
        do {
            scanf("%f", &d);
            if (d != 0) {
                if (!alist) {
                    alist = first(d);
                    apend = alist;
                } else {
                    add(&apend, d);
                }
            }
        } while (d != 0);
        
        // ввод списка b
        printf("Введите элементы списка b (0 - конец ввода):\\n");
        do {
            scanf("%f", &d);
            if (d != 0) {
                if (!blist) {
                    blist = first(d);
                    bpend = blist;
                } else {
                    add(&bpend, d);
                }
            }
        } while (d != 0);
        
        // вычисление s
        Node *aptr = alist;
        Node *bptr = blist;
        float s = 0;
        while (aptr && bptr) {
            s += aptr.d * (bptr.d - 1);
            aptr = aptr.next;
            bptr = bptr.next;
            if (!aptr && bptr) {
                aptr = alist;
            }
            if (!bptr && aptr) {
                bptr = blist;
            }
        }
        printf("Значение s = %f\\n", s);
        
        // освобождение памяти
        Node *ptr = alist;
        while (ptr) {
            Node *tmp = ptr;
            ptr = ptr.next;
            tmp = nil;
        }
        ptr = blist;
        while (ptr) {
            Node *tmp = ptr;
            ptr = ptr.next;
            tmp = nil;
        }
    }
    return 0;
}
