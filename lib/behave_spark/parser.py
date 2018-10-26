def to_dataframe(table):
    import pandas as pd
    import numpy as np
    from collections import defaultdict

    typemap = defaultdict(np.unicode_, str=np.unicode_, int=np.int32)
    parser = defaultdict(str, str=str, int=int)

    def to_name_type_tuple(heading):
        name_with_type = heading.split(":", maxsplit=1)
        type_or_default = (
            (name_with_type[1].strip()) if len(name_with_type) > 1 else "str"
        )

        return (
            name_with_type[0].strip(),
            typemap.get(type_or_default, np.unicode_),
            parser.get(type_or_default, str),
        )

    # def strip_types(headings):
    #     return [to_name_type_tuple(heading) for heading in headings]

    def from_gherkin_table(table):
        return {
            name_parser[0]: [name_parser[2](row[key]) for row in table]
            for key, name_parser in zip(
                table.headings, [to_name_type_tuple(key) for key in table.headings]
            )
        }

    return pd.DataFrame(
        data=from_gherkin_table(table),
        # TODO: dtype=[to_name_type_tuple(key)[1] for key in table.headings],
    )
