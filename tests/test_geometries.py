# SPDX-FileCopyrightText: 2023 NORCE
# SPDX-License-Identifier: GPL-3.0

"""Test the different type of grids."""

import os
import pathlib
import shutil

import pytest

dirname: pathlib.Path = pathlib.Path(__file__).parent


@pytest.mark.parametrize(
    "file",
    [
        "cake",
        "cartesian",
        "cartesian2d",
        "coord2d",
        "coord3d",
        "cpg3d",
        "radial",
        "tensor2d",
        "tensor3d",
    ],
)
def test_geometries(file: str, tmp_path):
    """See geometries/"""
    shutil.copy((dirname / "geometries" / file).with_suffix(".txt"), tmp_path)
    os.chdir(tmp_path)
    command = f"pyopmnearwell -i {file}.txt -o {file} & wait"
    print(command)
    os.system(command)
    assert (tmp_path / file / "postprocessing" / "saturation_2D.png").exists()
