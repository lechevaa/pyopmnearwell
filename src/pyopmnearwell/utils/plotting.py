"""Helper functions for plotting."""

from __future__ import annotations

import pathlib
import pickle

from matplotlib.figure import Figure


def save_fig_and_data(fig: Figure, path: pathlib.Path) -> None:
    """Save a pyplot figure to a png file and save the data to a pickle file.

    Args:
        fig (matplotlib.figure.Figure): The figure to save.
        path (pathlib.Path): The path to save the figure and data to.

    Returns:
        None

    """
    # Convert to a path in case a string was passed.
    path = pathlib.Path(path)

    # Save the figure to a png file
    # NOTE: Convert filename to str to ensure this works. With fig, ax = plt.subplots()
    # the conversion is not necessary, but with fig = plt.figure() it is.
    fig.savefig(str(path.with_suffix(".png")))

    # Save the data to a pickle file
    with path.with_suffix(".pickle").open("wb") as f:  # pylint: disable=C0103
        pickle.dump(fig, f)
