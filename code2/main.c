// int pos_ans = 0;
// int neg_ans = 0;


void pos_neg_sum(int *mas, int size);
//     while (size != 0) {
//         size--;
//         if (mas[size] < 0) {
//             neg_ans += mas[size];
//         } else {
//             pos_ans += mas[size];
//         }
//     }
//     printf("sum pos numbers = %d\n, sum neg numbers = %d\n", pos_ans, neg_ans);
// }

int main(void) {
    int size = 10;
    int mas[] = {0x80000000, 1, 2, 0x7FFFFFFF, -2, -3, 4, 5, -5, -10};
    pos_neg_sum(mas, size);
    return 0;
}