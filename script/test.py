import asyncio,time

async def func1(num):
    print(num,'before---func1----')

if __name__ == "__main__":
    begin = time.time()

    coroutine = func1(2)

    loop = asyncio.get_event_loop()
    loop.run_until_complete(coroutine)
    loop.close()
    end = time.time()
    print(end-begin)