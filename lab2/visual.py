import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
from itertools import islice

def draw2DPlot(xData, yData, xLabel='x', yLabel='y'):
    assert len(xData) == len(yData)
    plt.plot(xData, yData)
    ax = plt.gca()
    ax.set_ylabel(yLabel)
    ax.set_xlabel(xLabel)


def load(filename):
    with open(filename, 'r') as f:
        ret = np.array([[float(j) for j in i.split(' ') if j]
                        for i in f.read().split('\n') if i])
    return ret[:, 1:]

def drawData(data):
    counts, breakpoints = np.histogram(data, bins=6)

    breakpoints = list(map(np.mean, zip(breakpoints, islice(breakpoints, 1, None))))
    counts = counts / len(data) / (breakpoints[1] - breakpoints[0])
    draw2DPlot(breakpoints, counts)
    # draw2DPlot(range(len(hist)),)

    mu = np.mean(data)
    sigma = np.std(data)
    # mu = np.mean(data) 
    # sigma = 1
    x = np.linspace(mu - 3*sigma, mu + 3*sigma, 100)
    plt.plot(x,mlab.normpdf(x, mu, sigma))

    plt.show()

    # plt.hist(data, bins='auto')  # arguments are passed to np.histogram
    # plt.title("histogram")
    # plt.show()


def main():
    data1 = load('../iris/iris2.txt')
    data2 = load('../iris/iris3.txt')
    drawData(data1[:,2])
    # drawData(data2[:,2])

if __name__ == '__main__':
    main()
