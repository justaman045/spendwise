1. Login k baad back krne k baad logout ho jaa rha => completed
2. Refresh Indicator ko bhi shi krna => completed
3. Exclude Transaction => completed
4. auto_rebuild when on back => 


if (int.parse(valOne.value) == valTwo.id) {
                                  double updatedAmount;
                                  if (transaction.typeOfTransaction
                                          .toLowerCase() ==
                                      "income") {
                                    updatedAmount =
                                        valTwo.amount - transaction.amount;
                                  } else {
                                    if (multiSelectDropDownController
                                            .selectedItems.length >
                                        1) {
                                      updatedAmount = valTwo.amount +
                                          (transaction.amount /
                                              (multiSelectDropDownController
                                                      .selectedItems.length +
                                                  1));
                                    } else {
                                      updatedAmount =
                                          valTwo.amount + transaction.amount;
                                    }
                                  }
                                  if (updatedAmount == 0) {
                                    PeopleBalanceSharedMethods()
                                        .deletePeopleBalance(
                                            valTwo.transactionReferanceNumber);
                                  } else {
                                    PeopleBalanceSharedMethods()
                                        .updatePeopleBalance(
                                      PeopleBalance(
                                        name: valTwo.name,
                                        amount: updatedAmount,
                                        dateAndTime: valTwo.dateAndTime,
                                        transactionFor: valTwo.transactionFor,
                                        relationFrom: valTwo.relationFrom,
                                        transactionReferanceNumber:
                                            valTwo.transactionReferanceNumber,
                                      ),
                                    );
                                  }
                                }