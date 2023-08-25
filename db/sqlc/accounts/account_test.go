package accounts

import (
	"context"
	"math/rand"
	"testing"

	"github.com/go-faker/faker/v4"
	"github.com/stretchr/testify/require"
)


func TestCreateAccount(t *testing.T) {
	args := CreateAccountParams{
		Owner: faker.Name(),
		Balance: rand.Float64(),
		Currency: faker.Currency(),
	}

	account, err := testQueries.CreateAccount(context.Background(), args)

	require.NoError(t, err)
	require.NotEmpty(t, account)

	require.Equal(t, args.Owner, account.Owner)
	require.Equal(t, args.Balance, account.Balance)
	require.Equal(t, args.Currency, account.Currency)

	require.NotZero(t, account.ID)
	require.NotZero(t, account.CreatedAt)
}
